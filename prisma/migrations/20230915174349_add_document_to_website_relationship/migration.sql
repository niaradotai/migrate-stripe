/*
  Warnings:

  - You are about to drop the column `rankPosition` on the `contents` table. All the data in the column will be lost.
  - You are about to drop the `_ContentToDocument` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_ContentToDocument" DROP CONSTRAINT "_ContentToDocument_A_fkey";

-- DropForeignKey
ALTER TABLE "_ContentToDocument" DROP CONSTRAINT "_ContentToDocument_B_fkey";

-- AlterTable
ALTER TABLE "contents" DROP COLUMN "rankPosition";

-- DropTable
DROP TABLE "_ContentToDocument";

-- CreateTable
CREATE TABLE "documents_websites" (
    "documentId" TEXT NOT NULL,
    "contentId" TEXT NOT NULL,
    "rankPosition" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "documents_websites_pkey" PRIMARY KEY ("documentId","contentId")
);

-- AddForeignKey
ALTER TABLE "documents_websites" ADD CONSTRAINT "documents_websites_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "documents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents_websites" ADD CONSTRAINT "documents_websites_contentId_fkey" FOREIGN KEY ("contentId") REFERENCES "contents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
