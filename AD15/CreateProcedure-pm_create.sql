delimiter $$

DROP								PROCEDURE	IF EXISTS	`ad15`.`pm_create`	$$
CREATE DEFINER=`the_akademy`@`%` 	PROCEDURE 				`ad15`.`pm_create`	(

OUT $Status INTEGER(10) UNSIGNED ,
OUT $Step INTEGER(10) UNSIGNED ,
OUT $SocieteID INTEGER(10) UNSIGNED ,
IN $StatutJuridique VARCHAR(64) ,
IN $CodeSociete VARCHAR(8) ,
IN $RaisonSociale VARCHAR(128) ,
IN $Immatriculation VARCHAR(64) ,
IN $ImmatriculationSiege VARCHAR(64) ,
IN $VatNumber VARCHAR(64) ,
IN $Activite VARCHAR(255) ,
IN $Capital DECIMAL(16,0)
)
									NOT DETERMINISTIC
									MODIFIES SQL DATA

COMMENT 'Version 1.0 - 2018-12-12	Physical Person creation'

BEGIN
/*	========================================================================================================================
**	pp_create()						Physical Person creation
**	------------------------------------------------------------------------------------------------------------------------
**
**	TRANSACTIONAL	:				YES
**	CHECK-IN		:				YES
**	State			:				Released
**	-------------------------------------------------------------------------------------------------------------------------
**	Author			:				IT-DaaS - Isabelle LE TRONG
**
**	Versions 		:				1.0		2018-12-12	Initial version
**	-------------------------------------------------------------------------------------------------------------------------	
**	ARGUMENTS
**
**	OUT	$Status					INTEGER(10) 	UNSIGNED	:	Return code 0 = OK 
**	OUT	$Step					INTEGER(10) 	UNSIGNED	:	Reached step
**	OUT	$SocieteID				INTEGER(10)		UNSIGNED	:	Created Societe ID
**	
**	IN	$Nom					VARCHAR(128)				:	Nom PP
**	IN	$Prenom					VARCHAR(128)				:	Prénom PP
** ==========================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Signature				INTEGER(10) 	UNSIGNED	DEFAULT 300900							;
DECLARE	$Version				DECIMAL(4,2)	UNSIGNED	DEFAULT 1.0								;
/*
** (H) HANDLERs
**
** (H1) SQL Exceptions
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN	
	SET						$Status = $Signature													;
	ROLLBACK TO SAVEPOINT 	Start_pm_create															;
END																																;
/*
**	(0)	Set main output argument and set save point
*/

SET			$Step		=	$Signature																;
SET			$PpID		=	NULL																	;
	
SAVEPOINT 	Start_pp_create																			;
/*
/* To be continued
*/

/*
**			(EXIT)
*/
END
$$

