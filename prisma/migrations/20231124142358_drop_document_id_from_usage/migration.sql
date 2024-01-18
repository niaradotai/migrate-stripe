/*
  Warnings:

  - You are about to drop the column `documentId` on the `usage` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "usage" DROP CONSTRAINT "usage_documentId_fkey";

-- AlterTable
ALTER TABLE "usage" DROP COLUMN "documentId";
