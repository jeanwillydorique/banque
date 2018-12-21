
SET @StatutJuridique = 'SARL';
SET @CodeSociete = 'KTF';
SET @RaisonSociale = 'Kalisto';
SET @Immatriculation = '    503 234 379';
SET @ImmatriculationSiege= '    50323437900039';
SET @VatNumber = '656';
SET @Activite = 'COMMERCE';
SET @Capital = '1340';


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