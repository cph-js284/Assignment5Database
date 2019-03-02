USE `stackoverflow`;

DELIMITER $$

USE `stackoverflow`$$
DROP TRIGGER IF EXISTS `stackoverflow`.`matView_AFTER_INSERT` $$
DELIMITER ;
USE `stackoverflow`;

DELIMITER $$

USE `stackoverflow`$$
DROP TRIGGER IF EXISTS `stackoverflow`.`matView_AFTER_UPDATE` $$
DELIMITER ;
USE `stackoverflow`;

DELIMITER $$

USE `stackoverflow`$$
DROP TRIGGER IF EXISTS `stackoverflow`.`matView_AFTER_DELETE` $$
DELIMITER ;
DROP TRIGGER IF EXISTS `stackoverflow`.`posts_AFTER_INSERT`;

DELIMITER $$
USE `stackoverflow`$$
CREATE DEFINER = CURRENT_USER TRIGGER `stackoverflow`.`posts_AFTER_INSERT` AFTER INSERT ON `posts` FOR EACH ROW
BEGIN
	call CreateMatView();
END$$
DELIMITER ;
DROP TRIGGER IF EXISTS `stackoverflow`.`posts_AFTER_UPDATE`;

DELIMITER $$
USE `stackoverflow`$$
CREATE DEFINER = CURRENT_USER TRIGGER `stackoverflow`.`posts_AFTER_UPDATE` AFTER UPDATE ON `posts` FOR EACH ROW
BEGIN
	call CreateMatView();
END$$
DELIMITER ;
DROP TRIGGER IF EXISTS `stackoverflow`.`posts_AFTER_DELETE`;

DELIMITER $$
USE `stackoverflow`$$
CREATE DEFINER = CURRENT_USER TRIGGER `stackoverflow`.`posts_AFTER_DELETE` AFTER DELETE ON `posts` FOR EACH ROW
BEGIN
	call CreateMatView();
END$$
DELIMITER ;

