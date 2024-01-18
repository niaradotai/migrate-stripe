-- AlterTable
ALTER TABLE "accounts" ADD COLUMN     "isTrial" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "contents" ADD COLUMN     "objetives" TEXT,
ADD COLUMN     "publicationDate" TIMESTAMP(3),
ADD COLUMN     "secondaryKeywords" TEXT;

-- AlterTable
ALTER TABLE "conversations" ADD COLUMN     "function" TEXT,
ADD COLUMN     "model" TEXT NOT NULL DEFAULT 'gpt-3.5-turbo';
