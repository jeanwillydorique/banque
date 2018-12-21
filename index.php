<?php 
require_once('./function/function.php');
//var_dump($_SERVER["REQUEST_URI"]);die;
$uri = $_SERVER["REQUEST_URI"];
$decoupe = explode("/", $uri );

//var_dump($decoupe[1]);die;
if ($decoupe[1] === "index.php"  ) {

            $result = getCAByClient();
            $entete = "<table>";
            $entete .= "<tr>
                          <th>Nom de la Société</th>
                          <th>Code </th> 
                          <th>Nom Client</th>
                          <th>CA Client</th>
                          </tr>";
            echo $entete;
            foreach ($result as $key => $value) {
                  echo "<tr>";
                  echo "<td>" . $value["RaisonSocialeSociete"] . "</td>";
                  echo "<td>" . $value["CodeSociete"] . "</td>";
                  echo "<td>" . $value["NomClient"] . "</td>";
                  echo "<td>" . $value["CAClient"] . " € </td>";
                  echo "</tr>";
            }
            echo "</table>"; 
  }

else  {
  $decoupe[1]();
}


// </table>
