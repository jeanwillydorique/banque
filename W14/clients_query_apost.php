<?php
try
  {
/*
**  (1) Connexion à la base de données
*/
    $namehost   = 'localhost'                                                   ;
    $dbname     = 'it-akademy'                                                     ; 
    $username   = 'the_academy'                                                 ;
    $password   = '% lk0èCemlk$+Rt'                                             ;

    $DSN        = 'mysql:host='.$namehost.';dbname='.$dbname.';charset=utf8'    ;

    $database   = new PDO($DSN, $username, $password)                           ;
/*
**  (1) Récupération du nom saisi
*/
    if (isset($_POST['nom']))
        {
          $nom  = $_POST['nom']                                                ;
/*
**  (2) Recherche de tous les clients correspondants
*/       
          $sql_request  = ' SELECT    nom                       , 
                                      prenom                    ,
                                      mail
                            FROM      clients
                            WHERE     nom   LIKE \'%'.$nom.'%\' 
                            ORDER BY  nom, prenom               ;
                          '                                                   ;

          $clients      = $database->query($sql_request)                      ;
?>
<!DOCTYPE html>
<html lang="fr" >
   <head>
       <title>mes Clients</title>
       <meta charset="utf-8" />
   </head>

   <body>
    <form action="clients_query.php">
        <table>
            <tr>
               <td><br/></td>
             </tr>
            <tr>
               <td>NOM</td>
               <td><?php echo $nom ?></td>
            </tr><tr>
                <td><br/></td>
            </tr>
<?php
/*
**  (3) Affichage des clients
*/
          while($client   =   $clients->fetch())
            {
              $nom        =   $client['nom']                                 ;
              $prenom     =   $client['prenom']                              ;
              $email      =   $client['mail']                                ;
?>
            
             <tr>
               <td><?php echo htmlspecialchars($nom) ?></td>
               <td><?php echo htmlspecialchars($prenom) ?></td>
               <td><?php echo htmlspecialchars($email) ?></td>
            </tr>
<?php
            }
          $clients->closeCursor()                                           ;
?>
            <tr>
                <td></td>
                <td ><input type="submit" value="Valider" class="Valider" /></td>
            </tr>
        </table>
    </form>
  </body>
</html>
<?php
         }
  $database   = null                                                        ;
  }
catch(Exception $Exception)
  {
    die($Exception->getMessage())                                         ;
  }
?>
