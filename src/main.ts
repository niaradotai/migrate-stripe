import Stripe from "stripe";
import dayjs from "dayjs";
import path from "node:path";
import { PrismaClient } from "@prisma/client";
import { parseCSVToJSON } from "./parse-csv-to-json";
import { writeFileSync } from "node:fs";

const prisma = new PrismaClient();

const stripe = new Stripe(process.env.NIARA_STRIPE_SECRET_KEY!, {
  apiVersion: "2023-10-16",
});

const stripeOld = new Stripe(process.env.NIARA_STRIPE_SECRET_KEY_OLD!, {
  apiVersion: "2023-10-16",
});

const plansMap = new Map()
  .set("price_1NfqrmLVeyUUcwQSzITtP5jK", {
    name: "Plano Solo",
    newId: "price_1OX6F5LtBF5Auvn5XGLeBym7",
  })
  .set("price_1NfqrmLVeyUUcwQS1sF1rhbF", {
    name: "Plano Solo Anual",
    newId: "price_1OX6FWLtBF5Auvn50EF4MoTF",
  })
  .set("price_1OAtuALVeyUUcwQS5ObGt5kS", {
    name: "Plano Solo Black Friday",
    newId: "price_1OXTNyLtBF5Auvn53kiwlFQ8",
  })
  .set("price_1NfpHoLVeyUUcwQSEbwjfxIR", {
    name: "Plano Startup Mensal",
    newId: "price_1OXTG7LtBF5Auvn5uDmUcreH",
  })
  .set("price_1NfpHpLVeyUUcwQSOn9FId1G", {
    name: "Plano Startup Anual",
    newId: "price_1OXTGWLtBF5Auvn5PHlCgKu8",
  })
  .set("price_1OAu5VLVeyUUcwQSuuFLJYUC", {
    name: "Plano Startup Black Friday",
    newId: "price_1OXTOZLtBF5Auvn5e5WLXMHl",
  })
  .set("price_1NfpGSLVeyUUcwQSzcaLdfDM", {
    name: "Plano Pro Mensal",
    newId: "price_1OX6F5LtBF5Auvn5XGLeBym7",
  })
  .set("price_1NfpGSLVeyUUcwQSjGguzTDc", {
    name: "Plano Pro Anual",
    newId: "price_1OX6FWLtBF5Auvn50EF4MoTF",
  });

async function main() {
  const subscriptions = await parseCSVToJSON(
    path.resolve(".", "test-subscriptions-all-gmt.csv")
  );

  const invalidSubscriptions: Subscription[] = [];
  const notFoundAccountsCustomersIds: string[] = [];

  try {
    for (const subscription of subscriptions) {
      const oldSubscription = await stripeOld.subscriptions.retrieve(
        subscription.id
      );

      const oldPeriodEnd = oldSubscription.current_period_end;

      const {
        id: oldSubscriptionId,
        customer_id,
        status,
        start_date,
        cancel_at_period_end,
        plan: oldPlanId,
        payingClerkUserId,
        payingUserId,
        trial_end,
      } = subscription;

      // map new plan id from old plan id
      const newPlanId = plansMap.get(oldPlanId)?.newId;

      if (!newPlanId) {
        invalidSubscriptions.push(subscription);
        continue;
      }

      const billingCycleAnchor = oldPeriodEnd;

      const trialEndUnixTimestamp =
        oldSubscription.trial_end == null
          ? undefined
          : oldSubscription.trial_end;

      const startDateTimestamp = oldSubscription.start_date;

      const account = await prisma.account.findUnique({
        where: { stripeCustomerId: customer_id },
      });

      if (account) {
        // call stripe api to create new subscription
        const newSubscription = await stripe.subscriptions.create({
          customer: oldSubscription.customer as string,
          items: [{ price: newPlanId }],
          ...(status !== "trialing" && {
            billing_cycle_anchor: billingCycleAnchor,
            proration_behavior: "none",
            backdate_start_date: startDateTimestamp,
          }),
          cancel_at_period_end: cancel_at_period_end === "true" ? true : false,
          trial_end: status === "trialing" ? trialEndUnixTimestamp : undefined,
          metadata: {
            oldSubscriptionId,
            oldPlanId,
            payingClerkUserId,
            payingUserId,
          },
        });

        console.log("Subscription Created", newSubscription);

        // update subscription in db
        const subscriptionUpdate = await prisma.account.update({
          where: { stripeCustomerId: customer_id },
          data: {
            stripeSubscriptionId: newSubscription.id,
            stripePlanId: newPlanId,
          },
        });

        console.log("Subscription Updated", subscriptionUpdate);
      } else {
        notFoundAccountsCustomersIds.push(customer_id);
      }
    }
  } catch (error) {
    console.log(error);
  }

  writeFileSync(
    "invalid-subscriptions.json",
    JSON.stringify(invalidSubscriptions, null, 2)
  );
  writeFileSync(
    "not-found-accounts.json",
    JSON.stringify(notFoundAccountsCustomersIds, null, 2)
  );
  console.log("Invalid Subscriptions", invalidSubscriptions);
}

main();
