CREATE VIEW ListeClientCAParSociete AS 
( SELECT Societe, RaisonSocialeSociete, CodeSociete, Client, RaisonSociale AS NomClient, CAClient
FROM ad15.rcs
INNER JOIN 
        ( SELECT Societe, RaisonSociale AS RaisonSocialeSociete , CodeSociete, Client,CAClient
		FROM ad15.rcs
		INNER JOIN 
							(  SELECT T1.Societe, Code AS CodeSociete, Client, CAClient
							FROM ad15.societes
							INNER JOIN 
									( SELECT SUM(MontantHT) AS CAClient,  Societe, Client 	
									FROM ad15.factures_c
									GROUP BY Societe, Client)
									AS T1
							ON T1.Societe = societes.PM)
                            AS T2
		ON PM = Societe) 
        AS T3
ON PM = Client )
UNION
( SELECT Societe, RaisonSocialeSociete, CodeSociete, Client, Nom AS NomClient, CAClient
FROM ad15.pp
INNER JOIN 
        ( SELECT Societe, RaisonSociale AS RaisonSocialeSociete , CodeSociete, Client,CAClient
		FROM ad15.rcs
		INNER JOIN 
							(  SELECT T1.Societe, Code AS CodeSociete, Client, CAClient
							FROM ad15.societes
							INNER JOIN 
									( SELECT SUM(MontantHT) AS CAClient,  Societe, Client 	
									FROM ad15.factures_c
									GROUP BY Societe, Client)
									AS T1
							ON T1.Societe = societes.PM)
                            AS T2
		ON PM = Societe) 
        AS T3
ON Player = Client );