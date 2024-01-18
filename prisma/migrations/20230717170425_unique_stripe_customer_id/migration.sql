/*
  Warnings:

  - A unique constraint covering the columns `[clerkUserId]` on the table `accounts` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[stripeCustomerId]` on the table `accounts` will be added. If there are existing duplicate values, this will fail.
  - Made the column `clerkUserId` on table `accounts` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "accounts" ALTER COLUMN "clerkUserId" SET NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "accounts_clerkUserId_key" ON "accounts"("clerkUserId");

-- CreateIndex
CREATE UNIQUE INDEX "accounts_stripeCustomerId_key" ON "accounts"("stripeCustomerId");
