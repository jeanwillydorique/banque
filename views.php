<?php
require_once('./function/function.php');  
include_once('./template/header.php');
$req = getClient();

        echo "<p> Voici la liste des clients </p>";
        echo "<ul>";
        foreach ($req as $key => $value) {
            echo "<li>" . $value["RaisonSociale"] . "</li>";
        }
        echo "</ul>";
        echo '<a href="./form.php">Retour à la recherche</a>';





 include_once('./template/footer.php'); ?>
