delimiter $$

DROP								PROCEDURE	IF EXISTS	`nomenclature_insertFamily`	$$
CREATE DEFINER=`rns_manager`@`%` 	PROCEDURE 				`nomenclature_insertFamily`	(

OUT	$Status							INTEGER(10)	UNSIGNED										,
OUT	$Step							INTEGER(10)	UNSIGNED										,
OUT	$FamilyID						INTEGER(10)	UNSIGNED										,
OUT	$Level							SMALLINT(5)	UNSIGNED										,	

IN	$Parent 						VARCHAR(128)												,
IN	$Family							VARCHAR(128)												,
IN	$Description 					VARCHAR(255)
)
									NOT DETERMINISTIC
									MODIFIES SQL DATA

COMMENT 'Version 1.0 - 2018-08-14	Insertion d\'une Famille dans la table nomenclature'

BEGIN
/*	========================================================================================================
**	nomenclature_insertFamily()	Insertion d'une Famille dans la table nomenclature
**	--------------------------------------------------------------------------------------------------------
**
**	TRANSACTIONNEL	:				OUI
**	CHECK-IN		:				OUI
**	ETAT			:				Testée
**	--------------------------------------------------------------------------------------------------------
**	Auteur			:				IT-DaaS - Isabelle LE TRONG
**
**	Versions 		:				1.0		2018-08-14	Version initiale
**	---------------------------------------------------------------------------------------------------------	
**	PARAMETRES
**
**	OUT	$Status						INTEGER(10) 	UNSIGNED	:	Code Retour 0 = OK 
**	OUT	$Step						INTEGER(10) 	UNSIGNED	:	Etape Atteinte
**	OUT	$FamilyID					INTEGER(10)		UNSIGNED	:	ID Famille créée
**	OUT	$Level						SMALLINT(5)		UNSIGNED	:	Level Famille créée
**	
**	IN	$Parent						VARCHAR(128)				:	Famille parente ou NULL
**	IN	$Family						VARCHAR(128)				:	Nom Famille à insérer
**	IN	$Description 				VARCHAR(255)				:	Description Famille
** ==========================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Signature			INTEGER(10) 	UNSIGNED	DEFAULT 500100										;
DECLARE	$Version			DECIMAL(4,2)	UNSIGNED	DEFAULT 1.0											;
DECLARE	$RootID				INTEGER(10)		UNSIGNED	DEFAULT	1											;
DECLARE $BG 				INTEGER(10) 	UNSIGNED														;
DECLARE $BD 				INTEGER(10) 	UNSIGNED														;
/*
** (H) HANDLERs
**
** (H1) In case of unfound parent, link family to root
*/
DECLARE CONTINUE HANDLER FOR NOT FOUND
BEGIN
	SELECT 	id, Level, BG, BD
	FROM 	rns.nomenclature
	WHERE 	id = $RootID
	INTO 	$FamilyID, $Level,$BG, $BD																		;
END																											;
/*
** (H2) SQL Exception
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
	SET						$Status = $Signature															;
	ROLLBACK TO SAVEPOINT 	Start_nomenclature_insertFamily													;
END																											;
/*
**	(0)	Set main output argument and set save point
*/
SET			$Status		=	0																				;
SET			$Step		=	$Signature																		;
SET			$FamilyID	=	NULL																			;
SET			$Level		=	NULL																			;

SAVEPOINT 	Start_nomenclature_insertFamily																	;
/*
** (1) 		Locate Parent
*/
SELECT 		id, Level, BG, BD
FROM 		rns.nomenclature
WHERE 		Family = $Parent
INTO 		$FamilyID, $Level, $BG, $BD																		;

SET			$Step	=	$Signature	+	1																	;
/*
** (2)		Right insert
*/
UPDATE 		rns.nomenclature
	SET 	BD = BD + 2
WHERE 		BD >= $BD
ORDER BY 	BG DESC																							;

SET			$Step	=	$Signature	+	2																	;
/*
** (3)		Families shifting
*/
UPDATE 		rns.nomenclature
	SET 	BG = BG + 2
WHERE 		BG > $BD
ORDER BY 	BG DESC																							;

SET			$Step	=	$Signature	+	3																	;
/*
** (4)		Insert target Family
*/
SET			$Level		=	$Level	+	1																	;

INSERT INTO rns.nomenclature
	SET		Level		=	$Level			,
			Parent		=	$FamilyId		,
			BG			=	$BD				,
			BD			=	$BD		+	1	,
			Family		=	$Family			,
			Description	=	$Description																	;

SET			$Step		=	$Signature	+	4																;
SET			$FamilyID	=	LAST_INSERT_ID()																;
/*
**			(EXIT)
*/
END
$$

