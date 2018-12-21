SET	@From	=	'2018-01-01'	;
SET	@To		=	CURDATE()		;

SELECT	Commercial, Nom, Prenom, TotalCommission
FROM	ad26_2.PP
INNER JOIN	(
			SELECT 			SUM(Commissionnement*CaClient) AS TotalCommission, CS.Commercial
			FROM			ad26_2.commerciaux_societes	AS	CS
			INNER JOIN		(
							SELECT 			SUM(MontantHT) AS CaClient, FC.Client, Commercial, Societe
							FROM			ad26_2.factures_c			AS	FC
							INNER JOIN		ad26_2.commerciaux_clients	AS	CC
							ON				CC.Client	=	FC.Client
							WHERE			DateFacture	>=	@From
								AND			DateFacture	<=	@To
							GROUP BY		FC.Client, Commercial, Societe
							)
							AS	T1
			ON				CS.Commercial	=	T1.Commercial
				AND			CS.Societe		=	T1.Societe
			GROUP BY		Commercial
			)
			AS	T2
ON			Player	=	Commercial
ORDER BY 	Nom, Prenom	;
