delimiter $$

DROP TRIGGER IF EXISTS	`ad26_2`.`players_BINS`$$
CREATE
DEFINER=`iletrong`@`%`
TRIGGER `ad26_2`.`players_BINS`
BEFORE INSERT ON `ad26_2`.`players`
FOR EACH ROW
BEGIN
/* ==================================================================================
**	Versions	:	1.0		2017-03-21	Version initiale
**
**	Auteur		:	IT-DaaS	Isabelle LE TRONG	
** ==================================================================================
**
**	(D)		Internal datas
*/
DECLARE	$Version				DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0				;
DECLARE	$TypePending			VARCHAR(2)					DEFAULT	'PD'			;
/*
**	(T)		Trigger Prolog
**
**	(T.1)	Set Version, BirthTime and UpdateTime
*/
SET	NEW.Version		=	1															;
SET	NEW.BirthTime	=	NOW()														;
SET	NEW.UpdateTime	=	NEW.BirthTime												;
/*
**	(T.2)	Set Pending Type
*/
SET	NEW.Type		=	$TypePending												;
/*
**	(EXIT)
*/
END
$$
