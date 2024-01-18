/*
  Warnings:

  - Added the required column `title` to the `bulk_content` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
ALTER TYPE "BulkContentType" ADD VALUE 'IMAGE_SEO';

-- AlterTable
ALTER TABLE "bulk_content" ADD COLUMN     "title" TEXT NOT NULL;
