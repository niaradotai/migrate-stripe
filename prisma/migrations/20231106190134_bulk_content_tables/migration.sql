-- CreateEnum
CREATE TYPE "BulkContentType" AS ENUM ('PRODUCT_DESCRIPTION', 'META_TITLE', 'META_DESC');

-- CreateEnum
CREATE TYPE "BulkContentStatus" AS ENUM ('INITIAL', 'PENDING', 'FINISHED');

-- CreateEnum
CREATE TYPE "BulkContentItemStatus" AS ENUM ('INITIAL', 'PROCESSING', 'SUCCESS', 'ERROR');

-- AlterEnum
ALTER TYPE "UsageType" ADD VALUE 'BULK_CONTENT';

-- CreateTable
CREATE TABLE "bulk_content" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "rowCount" INTEGER NOT NULL,
    "status" "BulkContentStatus" NOT NULL DEFAULT 'INITIAL',
    "type" "BulkContentType" NOT NULL,

    CONSTRAINT "bulk_content_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bulk_content_item" (
    "id" TEXT NOT NULL,
    "bulkContentId" TEXT NOT NULL,
    "content" JSONB NOT NULL,
    "status" "BulkContentItemStatus" NOT NULL,

    CONSTRAINT "bulk_content_item_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bulk_content_item_usage" (
    "bulkContentItemId" TEXT NOT NULL,
    "usageId" TEXT NOT NULL,

    CONSTRAINT "bulk_content_item_usage_pkey" PRIMARY KEY ("bulkContentItemId","usageId")
);

-- CreateTable
CREATE TABLE "document_usage" (
    "documentId" TEXT NOT NULL,
    "usageId" TEXT NOT NULL,

    CONSTRAINT "document_usage_pkey" PRIMARY KEY ("documentId","usageId")
);

-- AddForeignKey
ALTER TABLE "bulk_content_item" ADD CONSTRAINT "bulk_content_item_bulkContentId_fkey" FOREIGN KEY ("bulkContentId") REFERENCES "bulk_content"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bulk_content_item_usage" ADD CONSTRAINT "bulk_content_item_usage_bulkContentItemId_fkey" FOREIGN KEY ("bulkContentItemId") REFERENCES "bulk_content_item"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bulk_content_item_usage" ADD CONSTRAINT "bulk_content_item_usage_usageId_fkey" FOREIGN KEY ("usageId") REFERENCES "usage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_usage" ADD CONSTRAINT "document_usage_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "documents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_usage" ADD CONSTRAINT "document_usage_usageId_fkey" FOREIGN KEY ("usageId") REFERENCES "usage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
