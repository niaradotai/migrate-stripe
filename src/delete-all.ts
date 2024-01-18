import Stripe from "stripe";

const stripe = new Stripe(process.env.NIARA_STRIPE_SECRET_KEY!, {
  apiVersion: "2023-10-16",
});

(async () => {
  const subscriptions = await stripe.subscriptions.list({
    limit: 100,
  });

  for (const subscription of subscriptions.data) {
    await stripe.subscriptions.cancel(subscription.id, {});
  }
  console.log("Subscriptions deleted! 🎉");
})();
