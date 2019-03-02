USE `stackoverflow`;
DROP procedure IF EXISTS `TransferCommentToPost`;

DELIMITER $$
USE `stackoverflow`$$
CREATE DEFINER=`root`@`%` PROCEDURE `TransferCommentToPost`(p_postId int, p_text text)
BEGIN
update posts set
    Comments = JSON_ARRAY_APPEND(Comments, '$', p_text)
     where Id = p_postId;
END$$

DELIMITER ;


