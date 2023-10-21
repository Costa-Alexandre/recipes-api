-- AlterTable
ALTER TABLE "PriceLog" ADD COLUMN     "userId" VARCHAR(36);

-- AddForeignKey
ALTER TABLE "PriceLog" ADD CONSTRAINT "PriceLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;
