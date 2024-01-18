/*
  Warnings:

  - Added the required column `accountId` to the `bulk_content` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "bulk_content" ADD COLUMN     "accountId" TEXT NOT NULL,
ADD COLUMN     "organizationId" TEXT;

-- AddForeignKey
ALTER TABLE "bulk_content" ADD CONSTRAINT "bulk_content_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "accounts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bulk_content" ADD CONSTRAINT "bulk_content_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "organizations"("id") ON DELETE SET NULL ON UPDATE CASCADE;
