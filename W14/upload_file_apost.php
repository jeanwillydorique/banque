<?php
define('OK',0)																												        	;
define('UPLOADED_DIR','uploaded_files/')																				;
$PermittedExtensions	=	array('pdf', 'jpg', 'jpeg', 'gif', 'png','php')					;

if (isset($_FILES['MyFile']['name']))
	{
		if ($_FILES['MyFile']['error'] == OK)
				{
/*
**	(1)		XFER OK, get extension and ckeck it
*/
				$FileInfos			= pathinfo($_FILES['MyFile']['name'])										;
				$FileExtension	 	= $FileInfos['extension']													   	;

				if (in_array($FileExtension, $PermittedExtensions))   
/*
**	(2)		Store uploaded file
*/              		{
						        echo $_FILES['MyFile']['name']	;
               			move_uploaded_file($_FILES['MyFile']['tmp_name'], UPLOADED_DIR.basename($_FILES['MyFile']['name']))		;
                		echo "Upload Done"																					;
                		}
            	else 	{    
            			echo "extension not permitted"																;
            			}
            	}
       else 	{
       			echo $_FILES['MyFile']['error'].' error'														;
       			}
    }
?>
