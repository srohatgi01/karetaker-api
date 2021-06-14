-- AlterTable
ALTER TABLE `pills` MODIFY `pill_time` CHAR(5);

-- AlterTable
ALTER TABLE `slots` MODIFY `start_time` CHAR(5),
    MODIFY `end_time` CHAR(5);
