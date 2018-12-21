SET	@Family			=	'STEP2'				;
SET	@Description	=	'Etape 2'				;
SET	@Parent			=	'TASK'							;

SET @@AUTOCOMMIT = 0							;
START TRANSACTION								;

CALL	nomenclature_insertFamily	(

							@Status		,
							@Step		,
							@FamilyID	,
							@Level		,

							@Parent 	,
							@Family		,
							@Description)		;

COMMIT											;
SET @@AUTOCOMMIT = 1							;

SELECT	@Status, @Step, @FamilyID, @Level							;