<?php
require_once('./function/function.php');  
include_once('./template/header.php');
$clients = getAllClients();

            $entete = "<table>";
            $entete .= "<tr>
                        <th>Nom</th>
                        <th>Prenom</th> 
                        <th>Mail</th>
                        </tr>";
            echo $entete;
            foreach ($clients as $key => $value) {
                echo "<tr>";
                echo "<td>" . $value["nom"] . "</td>";
                echo "<td>" . $value["prenom"] . "</td>";
                echo "<td>" . $value["mail"] . "</td>";
                echo "</tr>";
            }
            echo "</table>"; 
?>

            <form method=POST action="/insertClient">
            <label>Nom</label>
            <input type="text" name="Nom">
            <label>Prenom</label>
            <input type="text" name="Prenom">
            <label>Mail</label>
            <input type="text" name="Mail">
            <input type="submit" value="Insert">
            </form> 





 <?php include_once('./template/footer.php'); ?>