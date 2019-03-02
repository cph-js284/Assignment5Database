USE `stackoverflow`;
DROP procedure IF EXISTS `MySearch`;

DELIMITER $$
USE `stackoverflow`$$
CREATE DEFINER=`root`@`%` PROCEDURE `MySearch`(p_keyword text)
BEGIN
select *
from (
SELECT *
from matView
where JSON_EXTRACT(QandA, "$.Question", '$.Answer') like concat('%', p_keyword, '%')
) as JsonQandA
left join (
SELECT PostId, count(*) as KWCounter 
FROM comments 
where Text like concat('%', p_keyword, '%')
group by PostId) as commentsData on commentsData.PostId = JsonQandA.postId
where commentsData.KWCounter > 1;
END$$

DELIMITER ;


