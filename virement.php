<?php  
include_once('./template/header.php'); 
include_once('./function/function.php');
        $comptes = getAllComptes();

                    echo '<form method=POST action="/doVirement">';
                    echo '<label>Compte à Débiter</label>';
                    echo '<select name="CompteDebit">';

                    foreach ($comptes as $key => $value) {
                            echo '<option';
                            echo ' value="';
                            echo $value['numeroCompte'];
                            echo '">';
                            echo $value['nom'];
                            echo ' ';
                            echo $value['prenom'];
                            echo ' Solde = ';
                            echo $value['solde'];
                            echo ' Compte numéro = ';
                            echo $value['numeroCompte'];
                            echo '</option>';
                        };
                    echo '</select>';
                    echo '</br>';
                    echo '</br>';
                    echo '<label>Compte à Credit</label>';
                    echo '<select name="CompteCredit">';

                    foreach ($comptes as $key => $value) {
                            echo '<option';
                            echo ' value="';
                            echo $value['numeroCompte'];
                            echo '">';
                            echo $value['nom'];
                            echo ' ';
                            echo $value['prenom'];
                            echo ' Solde = ';
                            echo $value['solde'];
                            echo ' Compte numéro = ';
                            echo $value['numeroCompte'];
                            echo '</option>';
                        };
                    echo '</select>';
                    echo '</br>';
                    echo '</br>';
                    echo '<label>Montant</label>';
                    echo '<input type="number" name="montant">';
                    echo '</br>';
                    echo '</br>';
                    echo '<input type="submit" value="virement">';
                    echo '</form>';

include_once('./template/footer.php'); ?>