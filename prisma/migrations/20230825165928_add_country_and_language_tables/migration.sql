/*
  Warnings:

  - Added the required column `countryIsoCode` to the `contents` table without a default value. This is not possible if the table is not empty.
  - Added the required column `languageIsoCode` to the `contents` table without a default value. This is not possible if the table is not empty.
  - Added the required column `countryIsoCode` to the `documents` table without a default value. This is not possible if the table is not empty.
  - Added the required column `languageIsoCode` to the `documents` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "contents" ADD COLUMN     "countryIsoCode" TEXT NOT NULL,
ADD COLUMN     "languageIsoCode" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "documents" ADD COLUMN     "countryIsoCode" TEXT NOT NULL,
ADD COLUMN     "languageIsoCode" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "countries" (
    "isoCode" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "countries_pkey" PRIMARY KEY ("isoCode")
);

-- CreateTable
CREATE TABLE "languages" (
    "isoCode" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "languages_pkey" PRIMARY KEY ("isoCode")
);

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_countryIsoCode_fkey" FOREIGN KEY ("countryIsoCode") REFERENCES "countries"("isoCode") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_languageIsoCode_fkey" FOREIGN KEY ("languageIsoCode") REFERENCES "languages"("isoCode") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contents" ADD CONSTRAINT "contents_countryIsoCode_fkey" FOREIGN KEY ("countryIsoCode") REFERENCES "countries"("isoCode") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contents" ADD CONSTRAINT "contents_languageIsoCode_fkey" FOREIGN KEY ("languageIsoCode") REFERENCES "languages"("isoCode") ON DELETE RESTRICT ON UPDATE CASCADE;
