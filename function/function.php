<?php



function getCAByClient() {

    // identifiant et mot de passe

    $user = "root";
    $pass = "0000";

    // Connexion 

    $pdo = new PDO('mysql:host=localhost;dbname=ad15', $user, $pass);

    // requête préparation

    $stmt = $pdo->prepare('SELECT  * FROM ListeClientCAParSociete');

     // requête execution 
    $stmt->execute();

     // requête récuperation des données 
    return $stmt->fetchAll();
}




function getClient(){
    

        // identifiant et mot de passe

        $user = "root";
        $pass = "0000";
        $par = $_POST["Name"] . '%';
        // var_dump($par);die;
    
        // Connexion 
    
        $pdo = new PDO('mysql:host=localhost;dbname=ad15', $user, $pass);
    
        // requête préparation
        $stmt = $pdo->prepare('SELECT RaisonSociale FROM players 
                                INNER JOIN ad15.clients 
                                ON Player=Id
                                INNER JOIN ad15.rcs 
                                ON PM=Id
                                WHERE RaisonSociale LIKE "'.$par.'"');
         // requête execution 
        $stmt->execute();
    
         // requête récuperation des données 
        return $stmt->fetchAll();
}


function getAllClients() {

    // identifiant et mot de passe

    $user = "root";
    $pass = "0000";

    // Connexion 

    $pdo = new PDO('mysql:host=localhost;dbname=it_akademy', $user, $pass);

    // requête préparation

    $stmt = $pdo->prepare('SELECT  * FROM clients');

     // requête execution 
    $stmt->execute();

     // requête récuperation des données 
    return $stmt->fetchAll();
}

function insertClient() {



    //var_dump($_POST);die;

    // données post
    
    $nom = $_POST["Nom"];
    $prenom = $_POST["Prenom"];
    $mail = $_POST["Mail"];

    
    // identifiant et mot de passe

    $user = "root";
    $pass = "0000";

    // Connexion 

    $pdo = new PDO('mysql:host=localhost;dbname=it_akademy', $user, $pass);

    // requête préparation

    $insert = $pdo->prepare('INSERT INTO clients(nom, prenom, mail) VALUES (:nom, :prenom, :mail)'); 

     // requête execution 
     $insert->execute([
        ":nom" => $nom,
        ":prenom" => $prenom,
        ":mail" => $mail,
        ]) ;
    //redirection
    header('Location: ../allclient.php'); 
}


function getAllComptes() {

    // identifiant et mot de passe

    $user = "root";
    $pass = "0000";

    // Connexion 

    $pdo = new PDO('mysql:host=localhost;dbname=it_akademy', $user, $pass);

    // requête préparation

    $stmt = $pdo->prepare('SELECT nom, prenom, solde, comptes.id AS numeroCompte FROM it_akademy.comptes 
                            INNER JOIN it_akademy.clients
                            ON client = clients.id');

     // requête execution 
    $stmt->execute();

     // requête récuperation des données 
    return $stmt->fetchAll();
}


function doVirement() { 

    // recup des variables post 
    $compteDebit = $_POST["CompteDebit"];
    $compteCredit = $_POST["CompteCredit"];
    $montant = $_POST["montant"];


    // recuperation des comptes correspondants 

        // débiteur

                // identifiant et mot de passe

                $user = "root";
                $pass = "0000";

                // Connexion 

                $pdo = new PDO('mysql:host=localhost;dbname=it_akademy', $user, $pass);

                // requête préparation
            
                $stmt = $pdo->prepare('SELECT solde FROM it_akademy.comptes WHERE id=' . $compteDebit . '');
            
                // requête execution 
                $stmt->execute();
            
                // requête récuperation des données 
                $reqCompteDebit = $stmt->fetchAll();

        
        // créditeur

                // identifiant et mot de passe

                $user = "root";
                $pass = "0000";

                // Connexion 

                $pdo = new PDO('mysql:host=localhost;dbname=it_akademy', $user, $pass);

                // requête préparation

                $stmt = $pdo->prepare('SELECT solde FROM it_akademy.comptes WHERE id=' . $compteCredit . '');

                // requête execution 
                $stmt->execute();

                // requête récuperation des données 
                $reqCompteCredit = $stmt->fetchAll();


        // calcul du nouveau solde 

            // debit

                    foreach ($reqCompteDebit as $key => $soldeCompteDebit) {
                        $newSoldeCompteDebit = $soldeCompteDebit["solde"] - $montant;
                    }

            //credit 

                    foreach ($reqCompteCredit as $key => $soldeCompteCredit) {
                        $newSoldeCompteCredit = $soldeCompteCredit["solde"] + $montant;
                    }

        // Insert nouveau solde 

            // Insert compte Débit 

                // identifiant et mot de passe

                        $user = "root";
                        $pass = "0000";

                        // Connexion 

                        $pdo = new PDO('mysql:host=localhost;dbname=it_akademy', $user, $pass);

                        // requête préparation

                        $insertDebit = $pdo->prepare('UPDATE comptes SET solde = :solde WHERE id=' . $compteDebit . ''); 

                        // requête execution 
                        $insertDebit->execute([
                            ":solde" => $newSoldeCompteDebit,
                            ]) ;


                // Insert compte Credit 

                        // identifiant et mot de passe

                        $user = "root";
                        $pass = "0000";

                        // Connexion 

                        $pdo = new PDO('mysql:host=localhost;dbname=it_akademy', $user, $pass);

                        // requête préparation

                        $insertCredit = $pdo->prepare('UPDATE comptes SET solde = :solde WHERE id=' . $compteCredit . ''); 

                        // requête execution 
                        $insertCredit->execute([
                            ":solde" => $newSoldeCompteCredit,
                            ]) ;
   //redirection
    header('Location: ../virement.php'); 
  
}