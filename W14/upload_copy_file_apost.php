<?php
define('OK',0)																													;
define('UPLOADED_DIR','uploaded_files/')																						;
define('COPY_DIR','files_copies/')																								;
$PermittedExtensions	=	array('pdf', 'jpg', 'jpeg', 'gif', 'png','php')														;

if (isset($_FILES['MyFile']['name']))
	{
		if ($_FILES['MyFile']['error'] == OK)
				{
/*
**	(1)		XFER OK, get extension and ckeck it
*/
				$FileInfos			= pathinfo($_FILES['MyFile']['name'])														;
				$FileExtension	 	= $FileInfos['extension']																	;

				if (in_array($FileExtension, $PermittedExtensions))
/*
**	(2)		Store uploaded file
*/              		{
						echo $_FILES['MyFile']['name']	;
						$File 		=	basename($_FILES['MyFile']['name'])														;
						$UploadFile	=	UPLOADED_DIR.$File 																		;
               			move_uploaded_file($_FILES['MyFile']['tmp_name'], $UploadFile )											;
                		echo "Upload Done"																						;
/*
**	(3)		copy file
*/                		$file_source	=	fopen($UploadFile,'rb')																;
                		$file_target	=	fopen(COPY_DIR.$File,'wb')															;
                		$write_length	=	1																					;

                		while (!feof($file_source) AND $write_length	== 1)
                			{
                			$char			=	fread($file_source,$write_length)												;
                			$write_length	=	fwrite($file_target, $char, $write_length)										;
                			}
                		fclose($file_source)																					;
                		fclose($file_target)																					;
                		}
            	else 	{
            			echo "extension not permitted"																			;
            			}
            	}
       else 	{
       			echo $_FILES['MyFile']['error'].' error'																		;
       			}
    }
?>
