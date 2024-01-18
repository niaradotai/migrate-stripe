-- AlterTable
ALTER TABLE "entries" ADD COLUMN     "wordCount" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "messages" ADD COLUMN     "wordCount" INTEGER NOT NULL DEFAULT 0;
