<?php
session_start()                                                                     ;
try
  {
/*
**  (1) Connexion à la base de données
*/
    $namehost   = 'localhost'                                                       ;
    $dbname     = 'it-akademy'                                                      ; 
    $username   = 'the_academy'                                                     ;
    $password   = '% lk0èCemlk$+Rt'                                                 ;

    $DSN        = 'mysql:host='.$namehost.';dbname='.$dbname.';charset=utf8'        ;
/*
**  (1) Récupération des noms, prénoms et montant du virement
*/
    if (isset($_POST['nom_emetteur']))
        {
          $nom_emetteur  = $_POST['nom_emetteur']                                                                                  ;

          if (isset($_POST['prenom_emetteur']))
            {
            $prenom_emetteur  = $_POST['prenom_emetteur']                                                                          ;

            if (isset($_POST['nom_destinataire']))
                {
                $nom_destinataire  = $_POST['nom_destinataire']                                                                    ;

                if (isset($_POST['prenom_destinataire']))
                    {
                    $prenom_destinataire  = $_POST['prenom_destinataire']                                                          ;

                    if (isset($_POST['virement']))
                        {
                        if  (is_numeric($_POST['virement']))

                              {
                                $virement  = $_POST['virement']                                                                   ;
/*
**  (2) ouverture de base et début de transaction
*/
                                $database   = new PDO($DSN, $username, $password)                                                 ;

                                if (!is_null($database ))
                                    {
                                      if ($database->beginTransaction())
                                           {
/*
**  (3) Recherche des protagonistes
**
**  (3.1) Préparation requête commune
*/       
                                           $locate_client      =  '  SELECT    id
                                                                     FROM      clients
                                                                     WHERE     nom     = :nom
                                                                       AND     prenom  = :prenom
                                                                     ORDER BY  id
                                                                     LIMIT     1

                                                                    INTO      @id                   ;

                                                                    SELECT    @id                                                 ;
                                                                  '                                                               ;
                                          $prepared_request = $database->prepare($locate_client)                                  ;
/*
**  (3.2) Recherche émmeteur
*/             
                                          $prepared_request->bindParam(':nom'     , $nom_emetteur     , PDO::PARAM_STR)           ;
                                          $prepared_request->bindParam(':prenom'  , $prenom_emetteur  , PDO::PARAM_STR)           ;

                                          $prepared_request->execute()                                                            ;

                                          $prepared_request->nextRowset()                                                         ;
                                          $getArgument     = $prepared_request->fetch()                                           ;
                                          $id_emetteur     = (int)$getArgument['@id']                                             ;
                                          $prepared_request->closeCursor()                                                        ;
/*
**  (3.3) Recherche destinataire
*/  
                                          if  (!is_null($id_emetteur))
                                                {
                                                $prepared_request->bindParam(':nom'     , $nom_destinataire     , PDO::PARAM_STR) ;
                                                $prepared_request->bindParam(':prenom'  , $prenom_destinataire  , PDO::PARAM_STR) ;

                                                $prepared_request->execute()                                                      ;

                                                $prepared_request->nextRowset()                                                   ;
                                                $getArgument     = $prepared_request->fetch()                                     ;
                                                $id_destinataire = (int)$getArgument['@id']                                       ;
                                                $prepared_request->closeCursor()                                                  ;
/*
**  (4) Mise à jour des comptes associés
*/
                                                if  (!is_null($id_destinataire))
                                                      {
/*
**  (4.1) Préparation de la requête associée
*/
                                                      $update_compte    =   ' UPDATE    comptes
                                                                                SET     solde   = solde + :montant_virement
                                                                              WHERE     client  = :client
                                                                              ORDER BY  id
                                                                              LIMIT     1                                       ;
                                                                            '                                                                 ;
                                                      $prepared_request = $database->prepare($update_compte)                                  ;
/*
**  (4.1) débit du compte émetteur
*/                                                                    
                                                      $prepared_request->bindValue(':client'           , $id_emetteur , PDO::PARAM_INT)       ;
                                                      $prepared_request->bindValue(':montant_virement' , - $virement  , PDO::PARAM_STR)       ;
                                                      $prepared_request->execute()                                                            ;
/*
**  (4.2) débit du compte destinataire
*/
                                                      $prepared_request->bindValue(':client'           , $id_destinataire , PDO::PARAM_INT)   ;
                                                      $prepared_request->bindValue(':montant_virement' , $virement        , PDO::PARAM_STR)   ;
                                                      $prepared_request->execute()                                                            ;
/*
**  (5) Commit de la transaction
*/
                                                      $database->commit()                                                                     ;
                                                      $_SESSION['clients_virement_OK']  = true                                                ;
                                                     }
                                                }
                                          }
                                    }
                              }
                        }
                    }
                }
            }
        }
        $database = null                                                            ;
        header('Location: clients_virement.php')                                      ;
  }
catch(Exception $Exception)
  {
    $database->commit()                                                            ;
    die($Exception->getMessage())                                                  ;
  }
?>  
