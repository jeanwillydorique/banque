

CREATE VIEW ListeClientParSociete AS 
( SELECT Societe, RaisonSocialeSociete, CodeSociete, Client, RaisonSociale AS NomClient
FROM ad15.rcs
INNER JOIN 
		( SELECT Societe, RaisonSociale AS RaisonSocialeSociete , CodeSociete, Client
		FROM ad15.rcs
		INNER JOIN 
					(  SELECT DISTINCT Societe, Code AS CodeSociete, Client
					FROM ad15.factures_c 
					INNER JOIN societes 
					ON  factures_c.Societe = societes.PM )
					AS T1
		ON PM = Societe ) 
        AS T2
ON PM = Client ) 
UNION 
( SELECT Societe, RaisonSocialeSociete, CodeSociete, Client, Nom AS NomClient
FROM ad15.pp
INNER JOIN 
		( SELECT Societe, RaisonSociale AS RaisonSocialeSociete , CodeSociete, Client
		FROM ad15.rcs
		INNER JOIN 
					(  SELECT DISTINCT Societe, Code AS CodeSociete, Client
					FROM ad15.factures_c 
					INNER JOIN societes 
					ON  factures_c.Societe = societes.PM )
					AS T1
		ON PM = Societe ) 
        AS T2
ON Player = Client ) ; 
