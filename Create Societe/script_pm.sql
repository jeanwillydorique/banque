
SET @StatutJuridique = 'SA';
SET @CodeSociete = 'ITA';
SET @RaisonSociale = 'Formation';
SET @Immatriculation = '    503 253 379';
SET @ImmatriculationSiege= '    50325337900039';
SET @VatNumber = '666';
SET @Activite = 'Formation';
SET @Capital = '1500';


SET @@AUTOCOMMIT = 0;

START TRANSACTION;
CALL ad15.societes_create (
        @Status,
        @Step,
        @SocieteId,

        @StatutJuridique,
        @CodeSociete,
        @RaisonSociale,
        @Immatriculation,
        @ImmatriculationSiege,
        @VatNumber,
        @Activite,
        @Capital ); 
COMMIT ;
SELECT @Status,
                @Step,
                @SocieteId;