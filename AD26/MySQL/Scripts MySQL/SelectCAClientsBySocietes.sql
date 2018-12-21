(
SELECT		Societe, CodeSociete, RaisonSocialeSociete, Client,RaisonSociale AS	NomClient,CA
FROM		ad26_2.rcs
INNER JOIN	(
			SELECT		Societe, CodeSociete, Client, RaisonSociale AS	RaisonSocialeSociete, CA
			FROM		ad26_2.rcs
			INNER JOIN	(
						SELECT		Societe, Code AS CodeSociete, Client, CA
						FROM		ad26_2.societes
						INNER JOIN	(
									SELECT 			SUM(MontantHT)	AS	CA, Societe, Client
									FROM			ad26_2.factures_c
									GROUP BY		Societe, Client
									)
									AS	T1
						ON			PM	=	Societe
						)
						AS	T2
			ON			PM	=	Societe
			)
			AS	T3
ON			PM	=	Client
)
UNION
(
SELECT		Societe, CodeSociete, RaisonSocialeSociete, Client,CONCAT(Nom, ' ',Prenom) AS	NomClient,CA
FROM		ad26_2.pp
INNER JOIN	(
			SELECT		Societe, CodeSociete, Client, RaisonSociale AS	RaisonSocialeSociete, CA
			FROM		ad26_2.rcs
			INNER JOIN	(
						SELECT		Societe, Code AS CodeSociete, Client, CA
						FROM		ad26_2.societes
						INNER JOIN	(
									SELECT 			SUM(MontantHT)	AS	CA, Societe, Client
									FROM			ad26_2.factures_c
									GROUP BY		Societe, Client
									)
									AS	T1
						ON			PM	=	Societe
						)
						AS	T2
			ON			PM	=	Societe
			)
			AS	T3
ON			Player	=	Client
)
ORDER BY	CodeSociete, NomClient
