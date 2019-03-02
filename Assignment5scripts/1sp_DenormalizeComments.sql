DROP procedure IF EXISTS `denormalizeComments`;

DELIMITER $$
CREATE PROCEDURE `denormalizeComments` (p_postID INT)
BEGIN
update posts set Comments = (select json_arrayagg(Text) from comments where PostId = p_postID group by PostId) where Id = p_postID;
END$$

DELIMITER ;
