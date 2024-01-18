-- CreateEnum
CREATE TYPE "DocumentReferencesAnalysisStatus" AS ENUM ('INITIAL', 'SERP_DONE', 'LOADING_WEBSITES_RESUME', 'FULL_DONE');

-- AlterTable
ALTER TABLE "documents" ADD COLUMN     "referencesAnalysisStatus" "DocumentReferencesAnalysisStatus" NOT NULL DEFAULT 'INITIAL';
