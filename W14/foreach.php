<?php
$Annuaire = array 	(
					array('Nom'	=> 'Dupond', 'Prenom'=>'Marcel')	,
					array('Nom'	=> 'Dumoulin', 'Prenom'=>'Emile')
					)												;				
foreach($Annuaire AS  $Personne)
{
	foreach($Personne AS $Value)
		{
			echo $Value.' ';
		}
	echo '<br/>'	;
}
?>