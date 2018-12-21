delimiter $$

DROP								PROCEDURE	IF EXISTS	`ad15`.`societes_create`	$$
CREATE DEFINER=`the_akademy`@`%` 	PROCEDURE 				`ad15`.`societes_create`	(

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

COMMENT 'Version 1.0 - 2018-12-12	Societe creation'

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
DECLARE $StatutJuridiqueID     SMALLINT(5)     UNSIGNED    DEFAULT NULL							;
/*
** (H) HANDLERs
**
** (H1) SQL Exceptions
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN	
	SET						$Status = $Signature													;
	ROLLBACK TO SAVEPOINT 	Start_societes_create															;
END																																;
/*
**	(0)	Set main output argument and set save point
*/
SET			$Status		=	0												;	
SET			$Step		=	$Signature																;
SET			$SocieteID		=	NULL																	;

    
SAVEPOINT 	Start_societes_create																			;
/*
**			(1)	create player
*/
INSERT INTO	ad15.players
			(Type)
	VALUE	(@ad15_Statics_PlayerTypePD)															;

SET	$Step	=	$Signature	+	1																	;
SET	$SocieteID	=	LAST_INSERT_ID()																	;
SELECT  id FROM ad15.statuts_juridiques WHERE Libelle = $StatutJuridique INTO $StatutJuridiqueID    ;
IF ($StatutJuridiqueID IS NULL)
THEN
SET $Status = $Signature + 1 ; 
ELSE 
/*
**			(2)	insert  pp record
*/
INSERT INTO	ad15.pm
			(Player		, StatutJuridique)	
	VALUE	($SocieteID		,$StatutJuridiqueID )	
													;
SET	$Step	=	$Signature	+	2																	;
INSERT INTO ad15.societes
	(PM, Code)
VALUE ($SocieteID, $CodeSociete)
													;
SET	$Step	=	$Signature	+	3																	;
INSERT INTO ad15.rcs
		(PM	, RaisonSociale	, Immatriculation , ImmatriculationSiege , VatNumber , Activite , Capital)
VALUE ($SocieteID, $RaisonSociale	, $Immatriculation , $ImmatriculationSiege , $VatNumber , $Activite , $Capital)
													;


/*
**			(EXIT)
*/
END IF ;
END
$$
