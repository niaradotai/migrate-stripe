/*
  Warnings:

  - The values [LOADING_WEBSITES_RESUME] on the enum `DocumentReferencesAnalysisStatus` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "DocumentReferencesAnalysisStatus_new" AS ENUM ('INITIAL', 'SERP_DONE', 'FULL_DONE');
ALTER TABLE "documents" ALTER COLUMN "referencesAnalysisStatus" DROP DEFAULT;
ALTER TABLE "documents" ALTER COLUMN "referencesAnalysisStatus" TYPE "DocumentReferencesAnalysisStatus_new" USING ("referencesAnalysisStatus"::text::"DocumentReferencesAnalysisStatus_new");
ALTER TYPE "DocumentReferencesAnalysisStatus" RENAME TO "DocumentReferencesAnalysisStatus_old";
ALTER TYPE "DocumentReferencesAnalysisStatus_new" RENAME TO "DocumentReferencesAnalysisStatus";
DROP TYPE "DocumentReferencesAnalysisStatus_old";
ALTER TABLE "documents" ALTER COLUMN "referencesAnalysisStatus" SET DEFAULT 'INITIAL';
COMMIT;
