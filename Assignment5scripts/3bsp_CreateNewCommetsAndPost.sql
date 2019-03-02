USE `stackoverflow`;
DROP procedure IF EXISTS `CreateNewCommentAndPost`;

DELIMITER $$
USE `stackoverflow`$$
CREATE DEFINER=`root`@`%` PROCEDURE `CreateNewCommentAndPost`(p_postId int, p_text text, p_uid int)
begin
insert into comments 
	(PostId,Score,Text,CreationDate,UserId)
values
	(p_postId, 0, p_text, now(), p_uid);
call TransferCommentToPost(p_postId, p_text);
END$$

DELIMITER ;


