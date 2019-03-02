DROP TRIGGER IF EXISTS `stackoverflow`.`comments_AFTER_INSERT`;

DELIMITER $$
USE `stackoverflow`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `comments_AFTER_INSERT` AFTER INSERT ON `comments` FOR EACH ROW begin
	call denormalizeComments(New.PostId);
end$$
DELIMITER ;

