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

    $database   = new PDO($DSN, $username, $password)                               ;
/*
**  (1) Récupération des nom, prénom et email  saisis
*/
    if (isset($_POST['nom']))
        {
          $nom  = $_POST['nom']                                                     ;

          if (isset($_POST['prenom']))
            {
            $prenom  = $_POST['prenom']                                             ;

            if (isset($_POST['email']))
                {
                $email  = $_POST['email']                                           ;

/*
**  (2) Préparation de la requête d'insertion
*/       
                $sql_request      = ' INSERT INTO   clients
                                                   (nom    , prenom    ,  mail)
                                         VALUES    (:nom   , :prenom   ,  :email) ;
                                    '                                               ;
                $prepared_request = $database->prepare($sql_request)                ;             
                $prepared_request->bindParam(':nom'     , $nom     , PDO::PARAM_STR);
                $prepared_request->bindParam(':prenom'  , $prenom  , PDO::PARAM_STR);
                $prepared_request->bindParam(':email'   , $email   , PDO::PARAM_STR);
/*
**  (3) Execution de la requête
*/
                $prepared_request->execute()                                        ;

                $_SESSION['clients_insert_OK'] = true                               ;
                }
            }
        }
        $database = null                                                            ;
        header('Location: clients_insert.php')                                      ;
  }
catch(Exception $Exception)
  {
    die($Exception->getMessage())                                                  ;
  }
?>  
