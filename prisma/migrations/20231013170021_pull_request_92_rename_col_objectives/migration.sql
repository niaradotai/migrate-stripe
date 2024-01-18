/*
  Warnings:

  - You are about to drop the column `objetives` on the `contents` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "contents" DROP COLUMN "objetives",
ADD COLUMN     "objectives" TEXT;
