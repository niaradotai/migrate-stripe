/*
  Warnings:

  - Made the column `metaDescription` on table `contents` required. This step will fail if there are existing NULL values in that column.

*/
-- CreateEnum
CREATE TYPE "ContentResumeStatus" AS ENUM ('INITIAL', 'LOADING', 'SUCCESS', 'ERROR');

-- AlterTable
ALTER TABLE "contents" ADD COLUMN     "resumeResponseUrl" TEXT,
ADD COLUMN     "resumeStatus" "ContentResumeStatus" NOT NULL DEFAULT 'INITIAL';
