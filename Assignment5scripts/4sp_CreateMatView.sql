USE `stackoverflow`;
DROP procedure IF EXISTS `CreateMatView`;

DELIMITER $$
USE `stackoverflow`$$
CREATE DEFINER=`root`@`%` PROCEDURE `CreateMatView`()
BEGIN
Drop table if exists matView;
create table matView (
Id Int auto_increment not null primary key,
postId int not null,
UserName varchar(55),
Score int,
QandA Json
);
INSERT INTO `stackoverflow`.`matView`
(`postId`,`UserName`,`Score`,`QandA`)
select QAData.pId, QAData.UserName, QAData.Score, JSON_OBJECT("Question", QAData.Question, "Answer", QAData.Answer) 
from (select A.Id as pId, A.Body as Question, A.Score, B.Body as Answer, users.DisplayName as UserName
from posts A, posts B
inner join users on users.Id = B.OwnerUserId
where A.Id <> B.Id and A.AcceptedAnswerId = B.Id
) as QAData;

END$$

DELIMITER ;


