delimiter $$

DROP	TABLE			IF EXISTS	`nomenclature`								$$
CREATE	TABLE 						`nomenclature`								(

		`id` 			int(10) 	unsigned	NOT NULL 		AUTO_INCREMENT	,
		`Level` 		smallint(5) unsigned 	NOT NULL						,
		`Parent` 		int(10) 	unsigned 	NOT NULL						,
		`BG` 			int(10) 	unsigned 	NOT NULL						,
		`BD` 			int(10) 	unsigned 	NOT NULL						,
		`Family` 		varchar(128) 			NOT NULL						,
		`Description`	varchar(255) 			NOT NULL						,

  PRIMARY KEY (`id`)															,
  UNIQUE KEY `nomenclature_Family_idx` (`Family`)								,
  KEY `nomenclature_Parent_FK_idx` (`Parent`)									,
  KEY `nomenclature_BG_idx` (`BG`)												,
  KEY `nomenclature_BD_idx` (`BD`)												,

  CONSTRAINT `nomenclature_Parent_FK`
	FOREIGN KEY (`Parent`) REFERENCES `nomenclature` (`id`)
		ON DELETE RESTRICT
		ON UPDATE CASCADE

) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8							$$
/*
**	Initialisation de la table nomenclature
*/
INSERT	INTO	`nomenclature`
				(id, level,Parent, BG, BD, Family, Description)
	VALUES		(1, 0, 1, 1, 2, '$Root','Root of Nomenclature')					$$
