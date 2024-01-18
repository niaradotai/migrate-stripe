/*
  Warnings:

  - The `contentType` column on the `contents` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "ContentType" AS ENUM ('HTML', 'JSON', 'XML', 'PLAIN', 'IMAGE', 'PDF', 'WORD', 'EXCEL', 'POWER_POINT', 'AUDIO', 'VIDEO', 'CSV');

-- AlterTable
ALTER TABLE "contents" DROP COLUMN "contentType",
ADD COLUMN     "contentType" "ContentType";
