USE `stackoverflow`;
DROP procedure IF EXISTS `MySearch`;

DELIMITER $$
USE `stackoverflow`$$
CREATE DEFINER=`root`@`%` PROCEDURE `MySearch`(p_keyword text)
BEGIN
select JsonQandA.postId, commentsData.KWCounter
from 
(SELECT postId
from matView
where JSON_EXTRACT(QandA, "$.Question", '$.Answer') like concat('%', p_keyword, '%')) as JsonQandA
inner join 
(SELECT PostId, count(*) as KWCounter 
FROM comments 
where Text like concat('%', p_keyword, '%')
group by PostId Having KWCounter > 1) 
as commentsData on commentsData.PostId = JsonQandA.postId;
END$$

DELIMITER ;


