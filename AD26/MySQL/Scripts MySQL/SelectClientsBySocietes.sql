(
SELECT		Societe, CodeSociete, RaisonSocialeSociete, Client, RaisonSociale AS	NomClient
FROM		ad26_2.rcs
INNER JOIN	(
			SELECT		Societe, CodeSociete, RaisonSociale AS RaisonSocialeSociete, Client
FROM		ad26_2.rcs
			INNER JOIN	(
						SELECT DISTINCT	Societe, Code As CodeSociete, Client
						FROM			ad26_2.factures_c
						INNER JOIN		ad26_2.societes
						ON				Societe	=	PM
						)
						AS	T1
			ON			PM	=	Societe
			)
			AS	T2
ON			PM	=	Client
)
UNION
(
SELECT		Societe, CodeSociete, RaisonSocialeSociete, Client, CONCAT(Nom,' ', Prenom) AS	NomClient
FROM		ad26_2.pp
INNER JOIN	(
			SELECT		Societe, CodeSociete, RaisonSociale AS RaisonSocialeSociete, Client
FROM		ad26_2.rcs
			INNER JOIN	(
						SELECT DISTINCT	Societe, Code As CodeSociete, Client
						FROM			ad26_2.factures_c
						INNER JOIN		ad26_2.societes
						ON				Societe	=	PM
						)
						AS	T1
			ON			PM	=	Societe
			)
			AS	T2
ON			Player	=	Client
)
ORDER BY CodeSociete, NomClient