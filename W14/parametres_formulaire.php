<!DOCTYPE html>
<html lang="fr" >
   <head>
       <title>Mon Formulaire</title>
       <meta charset="utf-8" />
   </head>

   <body>
   	  <form action="parametres_formulaire_apost.php" method="post">
   			 <table>
            <tr>
               <td><br/></td>
             </tr>
   				  <tr>
   			  		 <td><label for="nom">NOM</label> : </td>
   						 <td><input type="text" name="nom" id="nom" /></td>
   					</tr>
             <tr>
               <td><label for="prenom">PRENOM</label> : </td>
               <td><input type="text" name="prenom" id="prenom" /></td>
            </tr>
            <tr>
                <td><br/></td>
            </tr>
            <tr>
   					    <td></td>
   					    <td ><input type="submit" value="Valider" class="Valider" /></td>
   					</tr>
   			</table>
    </form>
 	</body>
</html>