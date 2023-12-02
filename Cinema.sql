-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: Cinema
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Cinema`
--

DROP TABLE IF EXISTS `Cinema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cinema` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cinema`
--

LOCK TABLES `Cinema` WRITE;
/*!40000 ALTER TABLE `Cinema` DISABLE KEYS */;
INSERT INTO `Cinema` VALUES (1,'UGC Ciné','Paris'),(2,'Gaumont','Paris'),(3,'Pathé Parnasse','Paris'),(4,'Ciné Liberté','Brest'),(5,'Pathé','Rennes'),(6,'UGC Ciné','Lyon'),(7,'Pathé Vaise','Lyon');
/*!40000 ALTER TABLE `Cinema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Movie`
--

DROP TABLE IF EXISTS `Movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Movie` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_Cinema` int DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Director` varchar(255) DEFAULT NULL,
  `Duree` int DEFAULT NULL,
  `Langue` varchar(255) DEFAULT NULL,
  `DateDebut` date DEFAULT NULL,
  `DateFin` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_Cinema` (`ID_Cinema`),
  CONSTRAINT `Movie_ibfk_1` FOREIGN KEY (`ID_Cinema`) REFERENCES `Cinema` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Movie`
--

LOCK TABLES `Movie` WRITE;
/*!40000 ALTER TABLE `Movie` DISABLE KEYS */;
INSERT INTO `Movie` VALUES (4,1,'Five Nights At Freddy\'s','Emma Tammi',110,'VOSTFR','2024-01-01','2024-01-15'),(5,2,'Five Nights At Freddy\'s','Emma Tammi',110,'VOSTFR','2024-01-01','2024-01-15'),(6,3,'Five Nights At Freddy\'s','Emma Tammi',110,'VOSTFR','2024-01-01','2024-01-15'),(7,6,'Five Nights At Freddy\'s','Emma Tammi',110,'VO','2023-12-01','2023-12-15'),(8,1,'The Marvels','Nia DaCosta',105,'VF','2024-01-05','2024-01-30'),(9,3,'The Marvels','Nia DaCosta',105,'VF','2024-01-05','2024-01-30'),(10,4,'The Marvels','Nia DaCosta',105,'VF','2024-01-05','2024-01-30'),(11,5,'Napoléon','Ridley Scott',158,'VF','2024-02-10','2024-03-01'),(12,6,'Napoléon','Ridley Scott',158,'VF','2024-02-10','2024-03-01'),(13,1,'Napoléon','Ridley Scott',158,'VF','2024-02-10','2024-03-01');
/*!40000 ALTER TABLE `Movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MoviesAPI`
--

DROP TABLE IF EXISTS `MoviesAPI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MoviesAPI` (
  `_id` bigint NOT NULL,
  `backdrop_path` text,
  `genres` text,
  `original_title` text,
  `overview` text,
  `poster_path` text,
  `release_date` text,
  `title` text,
  `contentType` text,
  `ID_Cinema` int DEFAULT NULL,
  PRIMARY KEY (`_id`),
  KEY `fk_cinema` (`ID_Cinema`),
  CONSTRAINT `fk_cinema` FOREIGN KEY (`ID_Cinema`) REFERENCES `Cinema` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MoviesAPI`
--

LOCK TABLES `MoviesAPI` WRITE;
/*!40000 ALTER TABLE `MoviesAPI` DISABLE KEYS */;
INSERT INTO `MoviesAPI` VALUES (118340,'https://image.tmdb.org/t/p/original/uLtVbjvS1O7gXL8lUOwsFOH4man.jpg','Action & Adventure, Sci-Fi & Fantasy, Action & Adventure','Guardians of the Galaxy','Light years from Earth, 26 years after being abducted, Peter Quill finds himself the prime target of a manhunt after discovering an orb wanted by Ronan the Accuser.','https://image.tmdb.org/t/p/original/r7vmZjiyZw9rpJMQJdXpjgiCOk9.jpg','2014-07-30','Guardians of the Galaxy','movie',4),(265712,'https://image.tmdb.org/t/p/original/1aABIiqBY7yoQESE8qWvR0w9bJZ.jpg','Animation, Family, Sci-Fi & Fantasy, Sci-Fi & Fantasy','STAND BY ME ドラえもん','Sewashi and Doraemon find themselves way back in time and meet Nobita. It is up to Doraemon to take care of Nobita or else he will not return to the present.','https://image.tmdb.org/t/p/original/wc7XQbfx6EIQqCuvmBMt3aisb2Y.jpg','2014-08-08','Stand by Me Doraemon','movie',7),(283995,'https://image.tmdb.org/t/p/original/aJn9XeesqsrSLKcHfHP4u5985hn.jpg','Action & Adventure, Action & Adventure, Sci-Fi & Fantasy','Guardians of the Galaxy Vol. 2','The Guardians must fight to keep their newfound family together as they unravel the mysteries of Peter Quill\'s true parentage.','https://image.tmdb.org/t/p/original/y4MBh0EjBlMuOzv9axM4qJlmhzz.jpg','2017-04-19','Guardians of the Galaxy Vol. 2','movie',2),(299536,'https://image.tmdb.org/t/p/original/mDfJG3LC3Dqb67AZ52x3Z0jU0uB.jpg','Action & Adventure, Action & Adventure, Sci-Fi & Fantasy','Avengers: Infinity War','As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos. A despot of intergalactic infamy, his goal is to collect all six Infinity Stones, artifacts of unimaginable power, and use them to inflict his twisted will on all of reality. Everything the Avengers have fought for has led up to this moment - the fate of Earth and existence itself has never been more uncertain.','https://image.tmdb.org/t/p/original/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg','2018-04-25','Avengers: Infinity War','movie',6),(315162,'https://image.tmdb.org/t/p/original/jr8tSoJGj33XLgFBy6lmZhpGQNu.jpg','Animation, Family, Sci-Fi & Fantasy, Action & Adventure, Comedy','Puss in Boots: The Last Wish','Puss in Boots discovers that his passion for adventure has taken its toll: He has burned through eight of his nine lives, leaving him with only one life left. Puss sets out on an epic journey to find the mythical Last Wish and restore his nine lives.','https://image.tmdb.org/t/p/original/kuf6dutpsT0vSVehic3EZIqkOBt.jpg','2022-12-07','Puss in Boots: The Last Wish','movie',6),(361743,'https://image.tmdb.org/t/p/original/AaV1YIdWKnjAIAOe8UUKBFm327v.jpg','Action & Adventure, Drama','Top Gun: Maverick','After more than thirty years of service as one of the Navy’s top aviators, and dodging the advancement in rank that would ground him, Pete “Maverick” Mitchell finds himself training a detachment of TOP GUN graduates for a specialized mission the likes of which no living pilot has ever seen.','https://image.tmdb.org/t/p/original/62HCnUTziyWcpDaBO2i1DX17ljH.jpg','2022-05-24','Top Gun: Maverick','movie',6),(420808,'https://image.tmdb.org/t/p/original/8HfjrSxfTVKmjNh8cJjbu5eXzcX.jpg','Family, Sci-Fi & Fantasy, Action & Adventure, Action & Adventure','Peter Pan & Wendy','Wendy Darling, a young girl afraid to leave her childhood home behind, meets Peter Pan, a boy who refuses to grow up. Alongside her brothers and a tiny fairy, Tinker Bell, she travels with Peter to the magical world of Neverland. There, she encounters an evil pirate captain, Captain Hook, and embarks on a thrilling adventure that will change her life forever.','https://image.tmdb.org/t/p/original/9NXAlFEE7WDssbXSMgdacsUD58Y.jpg','2023-04-20','Peter Pan & Wendy','movie',3),(436270,'https://image.tmdb.org/t/p/original/bQXAqRx2Fgc46uCVWgoPz5L5Dtr.jpg','Action & Adventure, Action & Adventure, Sci-Fi & Fantasy, Sci-Fi & Fantasy','Black Adam','Nearly 5,000 years after he was bestowed with the almighty powers of the Egyptian gods—and imprisoned just as quickly—Black Adam is freed from his earthly tomb, ready to unleash his unique form of justice on the modern world.','https://image.tmdb.org/t/p/original/pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg','2022-10-19','Black Adam','movie',2),(453395,'https://image.tmdb.org/t/p/original/iKUwhA4DUxMcNKu5lLSbDFwwilk.jpg','Sci-Fi & Fantasy, Action & Adventure, Action & Adventure','Doctor Strange in the Multiverse of Madness','Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.','https://image.tmdb.org/t/p/original/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg','2022-05-04','Doctor Strange in the Multiverse of Madness','movie',4),(493529,'https://image.tmdb.org/t/p/original/20uHjZ4yCPD2x0ndcxZaxM7hLIy.jpg','Action & Adventure, Sci-Fi & Fantasy, Comedy','Dungeons & Dragons: Honor Among Thieves','A charming thief and a band of unlikely adventurers undertake an epic heist to retrieve a lost relic, but things go dangerously awry when they run afoul of the wrong people.','https://image.tmdb.org/t/p/original/v7UF7ypAqjsFZFdjksjQ7IUpXdn.jpg','2023-03-23','Dungeons & Dragons: Honor Among Thieves','movie',5),(505642,'https://image.tmdb.org/t/p/original/xDMIl84Qo5Tsu62c9DGWhmPI67A.jpg','Action & Adventure, Action & Adventure, Sci-Fi & Fantasy','Black Panther: Wakanda Forever','Queen Ramonda, Shuri, M’Baku, Okoye and the Dora Milaje fight to protect their nation from intervening world powers in the wake of King T’Challa’s death.  As the Wakandans strive to embrace their next chapter, the heroes must band together with the help of War Dog Nakia and Everett Ross and forge a new path for the kingdom of Wakanda.','https://image.tmdb.org/t/p/original/sv1xJUazXeYqALzczSZ3O6nkH75.jpg','2022-11-09','Black Panther: Wakanda Forever','movie',6),(616037,'https://image.tmdb.org/t/p/original/jsoz1HlxczSuTx0mDl2h0lxy36l.jpg','Sci-Fi & Fantasy, Action & Adventure, Comedy','Thor: Love and Thunder','After his retirement is interrupted by Gorr the God Butcher, a galactic killer who seeks the extinction of the gods, Thor Odinson enlists the help of King Valkyrie, Korg, and ex-girlfriend Jane Foster, who now wields Mjolnir as the Mighty Thor. Together they embark upon a harrowing cosmic adventure to uncover the mystery of the God Butcher’s vengeance and stop him before it’s too late.','https://image.tmdb.org/t/p/original/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg','2022-07-06','Thor: Love and Thunder','movie',4),(619930,'https://image.tmdb.org/t/p/original/ogFIG0fNXEYRQKrpnoRJcXQNX9n.jpg','War, Drama, History, Action & Adventure','Kampen om Narvik','April, 1940. The eyes of the world are on Narvik, a small town in northern Norway, a source of the iron ore needed for Hitler\'s war machine. Through two months of fierce winter warfare, the German leader is dealt with his first defeat.','https://image.tmdb.org/t/p/original/gU4mmINWUF294Wzi8mqRvi6peMe.jpg','2022-12-25','Narvik','movie',5),(631842,'https://image.tmdb.org/t/p/original/aHcWyh0n4YbBy9gxYCDlgsNVS3M.jpg','Horror','Knock at the Cabin','While vacationing at a remote cabin, a young girl and her two fathers are taken hostage by four armed strangers who demand that the family make an unthinkable choice to avert the apocalypse. With limited access to the outside world, the family must decide what they believe before all is lost.','https://image.tmdb.org/t/p/original/dm06L9pxDOL9jNSK4Cb6y139rrG.jpg','2023-02-01','Knock at the Cabin','movie',5),(634649,'https://image.tmdb.org/t/p/original/14QbnygCuTO0vl7CAFmPf1fgZfV.jpg','Action & Adventure, Action & Adventure, Sci-Fi & Fantasy','Spider-Man: No Way Home','Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.','https://image.tmdb.org/t/p/original/uJYYizSuA9Y3DCs0qS4qWvHfZg4.jpg','2021-12-15','Spider-Man: No Way Home','movie',7),(635302,'https://image.tmdb.org/t/p/original/xPpXYnCWfjkt3zzE0dpCNME1pXF.jpg','Animation, Action & Adventure, Action & Adventure, Sci-Fi & Fantasy, Thriller','劇場版「鬼滅の刃」無限列車編','Tanjiro Kamado, joined with Inosuke Hashibira, a boy raised by boars who wears a boar\'s head, and Zenitsu Agatsuma, a scared boy who reveals his true power when he sleeps, boards the Infinity Train on a new mission with the Fire Hashira, Kyojuro Rengoku, to defeat a demon who has been tormenting the people and killing the demon slayers who oppose it!','https://image.tmdb.org/t/p/original/h8Rb9gBr48ODIwYUttZNYeMWeUU.jpg','2020-10-16','Demon Slayer -Kimetsu no Yaiba- The Movie: Mugen Train','movie',6),(638974,'https://image.tmdb.org/t/p/original/bT3IpP7OopgiVuy6HCPOWLuaFAd.jpg','Comedy, Crime','Murder Mystery 2','After starting their own detective agency, Nick and Audrey Spitz land a career-making case when their billionaire pal is kidnapped from his wedding.','https://image.tmdb.org/t/p/original/s1VzVhXlqsevi8zeCMG9A16nEUf.jpg','2023-03-28','Murder Mystery 2','movie',6),(675353,'https://image.tmdb.org/t/p/original/yEQqrW61rwNuVRHTjgHOAU4dXNE.jpg','Action & Adventure, Action & Adventure, Family, Comedy','Sonic the Hedgehog 2','After settling in Green Hills, Sonic is eager to prove he has what it takes to be a true hero. His test comes when Dr. Robotnik returns, this time with a new partner, Knuckles, in search for an emerald that has the power to destroy civilizations. Sonic teams up with his own sidekick, Tails, and together they embark on a globe-trotting journey to find the emerald before it falls into the wrong hands.','https://image.tmdb.org/t/p/original/6DrHO1jr3qVrViUO6s6kFiAGM7.jpg','2022-04-08','Sonic the Hedgehog 2','movie',3),(736526,'https://image.tmdb.org/t/p/original/53BC9F2tpZnsGno2cLhzvGprDYS.jpg','Sci-Fi & Fantasy, Action & Adventure, Action & Adventure, Thriller','Troll','Deep inside the mountain of Dovre, something gigantic awakens after being trapped for a thousand years. Destroying everything in its path, the creature is fast approaching the capital of Norway. But how do you stop something you thought only existed in Norwegian folklore?','https://image.tmdb.org/t/p/original/9z4jRr43JdtU66P0iy8h18OyLql.jpg','2022-12-01','Troll','movie',5),(736790,'https://image.tmdb.org/t/p/original/aityu1Gma509jInlspHstEt8Jg0.jpg','Action & Adventure, Sci-Fi & Fantasy, Family','Chupa','While visiting family in Mexico, a lonely boy befriends a mythical creature hiding on his grandfather\'s ranch and embarks on the adventure of a lifetime.','https://image.tmdb.org/t/p/original/ra3xm8KFAkwK0CdbPRkfYADJYTB.jpg','2023-04-07','Chupa','movie',1),(768744,'https://image.tmdb.org/t/p/original/faek7NPiZqTZhstTfLQG1saw08D.jpg','Animation, Action & Adventure, Action & Adventure, Sci-Fi & Fantasy','僕のヒーローアカデミア THE MOVIE ワールド ヒーローズ ミッション','A mysterious group called Humarize strongly believes in the Quirk Singularity Doomsday theory which states that when quirks get mixed further in with future generations, that power will bring forth the end of humanity. In order to save everyone, the Pro-Heroes around the world ask UA Academy heroes-in-training to assist them and form a world-class selected hero team. It’s up to the heroes to save the world and the future of heroes in what is the most dangerous crisis to take place yet in My Hero Academia.','https://image.tmdb.org/t/p/original/AsTlA7dj2ySGY1pzGSD0MoHFhEF.jpg','2021-08-06','My Hero Academia: World Heroes\' Mission','movie',3),(774752,'https://image.tmdb.org/t/p/original/nJbWAc8wakV3BncyF4643SyFWPr.jpg','Comedy, Sci-Fi & Fantasy, Action & Adventure','The Guardians of the Galaxy Holiday Special','On a mission to make Christmas unforgettable for Quill, the Guardians head to Earth in search of the perfect present.','https://image.tmdb.org/t/p/original/8dqXyslZ2hv49Oiob9UjlGSHSTR.jpg','2022-11-25','The Guardians of the Galaxy Holiday Special','movie',7),(804150,'https://image.tmdb.org/t/p/original/a2tys4sD7xzVaogPntGsT1ypVoT.jpg','Thriller, Comedy, Crime','Cocaine Bear','Inspired by a true story, an oddball group of cops, criminals, tourists and teens converge in a Georgia forest where a 500-pound black bear goes on a murderous rampage after unintentionally ingesting cocaine.','https://image.tmdb.org/t/p/original/gOnmaxHo0412UVr1QM5Nekv1xPi.jpg','2023-02-22','Cocaine Bear','movie',7),(829560,'https://image.tmdb.org/t/p/original/6cpRpfD3isvluFwXDGSiDVyibPJ.jpg','Romance, Drama','Kolejne 365 dni','Laura and Massimo\'s relationship hangs in the balance as they try to overcome trust issues while a tenacious Nacho works to push them apart.','https://image.tmdb.org/t/p/original/6FsGeIp7heHm5eh4tIxTzHIRxmt.jpg','2022-08-19','The Next 365 Days','movie',5),(843794,'https://image.tmdb.org/t/p/original/afsYFdid9pnnRd6tTrHFUbHgXJn.jpg','Sci-Fi & Fantasy','정이','On an uninhabitable 22nd-century Earth, the outcome of a civil war hinges on cloning the brain of an elite soldier to create a robot mercenary.','https://image.tmdb.org/t/p/original/z2nfRxZCGFgAnVhb9pZO87TyTX5.jpg','2023-01-20','JUNG_E','movie',5),(849869,'https://image.tmdb.org/t/p/original/tYcmm8XtzRdcT6kliCbHuWwLCwB.jpg','Action & Adventure, Crime, Thriller','길복순','At work, she\'s a renowned assassin. At home, she\'s a single mom to a teenage daughter. Killing? That\'s easy. It\'s parenting that\'s the hard part.','https://image.tmdb.org/t/p/original/taYgn3RRpCGlTGdaGQvnSIOzXFy.jpg','2023-02-17','Kill Boksoon','movie',5),(860425,'https://image.tmdb.org/t/p/original/1Txzm4bY5ZDqvgMl7MmHeBMl7HH.jpg','Crime, Drama, Thriller','Sinaliento','In the DR, hardened cop Manolo tries to take down an infamous drug cartel; meanwhile, his daughter has fallen in love with Lorenzo, a construction worker who\'s unwittingly gotten embroiled in the drug cartel\'s dealings.','https://image.tmdb.org/t/p/original/oxNoVgbu2v9ETL93Kri1pw8osYf.jpg','2021-08-11','Breathless','movie',4),(868759,'https://image.tmdb.org/t/p/original/b9UCfDzwiWw7mIFsIQR9ZJUeh7q.jpg','Action & Adventure, Comedy, Romance','Ghosted','Salt-of-the-earth Cole falls head over heels for enigmatic Sadie — but then makes the shocking discovery that she’s a secret agent. Before they can decide on a second date, Cole and Sadie are swept away on an international adventure to save the world.','https://image.tmdb.org/t/p/original/liLN69YgoovHVgmlHJ876PKi5Yi.jpg','2023-04-18','Ghosted','movie',1),(868985,'https://image.tmdb.org/t/p/original/3uHDuQCoJQ6DhRlI3frd7p9WSE2.jpg','Drama, Comedy','¡Que Viva México!','After his grandfather\'s death, a man travels with his wife and kids to his hometown, where chaos ensues with his relatives over the inheritance.','https://image.tmdb.org/t/p/original/ieyUpr5ES9QEz1cn4clCnBf9XJl.jpg','2023-03-23','¡Que Viva México!','movie',5),(869626,'https://image.tmdb.org/t/p/original/1PRWW60yQparK1I8Soyy9Evf7Dv.jpg','Animation, Comedy, Family, Drama, Action & Adventure','Marcel the Shell with Shoes On','Marcel is an adorable one-inch-tall shell who ekes out a colorful existence with his grandmother Connie and their pet lint, Alan. Once part of a sprawling community of shells, they now live alone as the sole survivors of a mysterious tragedy. But when a documentary filmmaker discovers them amongst the clutter of his Airbnb, the short film he posts online brings Marcel millions of passionate fans, as well as unprecedented dangers and a new hope at finding his long-lost family.','https://image.tmdb.org/t/p/original/jaYmP4Ct8YLnxWAW2oYkUjeXtzm.jpg','2022-06-24','Marcel the Shell with Shoes On','movie',3),(873256,'https://image.tmdb.org/t/p/original/m0mLjT3TkTXYU2e1XP3wmYDlIml.jpg','Romance, Comedy','Gorzko, gorzko!','Convinced he can charm any woman, a tenacious flirt sets his sights on a headstrong bride-to-be engaged to the son of an ambitious politician.','https://image.tmdb.org/t/p/original/kqltY4yywn4ex1Cht6f4lercrW4.jpg','2023-04-26','Kiss, Kiss!','movie',1),(899294,'https://image.tmdb.org/t/p/original/eyiSLRh44SKKWIJ6bxWq8z1sscB.jpg','Thriller, Horror, Crime','Frank and Penelope','A tale of love and violence when a man on his emotional last legs finds a savior seductively dancing in a run-down strip club. And a life most certainly headed off a cliff suddenly becomes redirected - as everything is now worth dying for.','https://image.tmdb.org/t/p/original/5NpXoAi3nEQkEgLO09nmotPfyNa.jpg','2022-06-03','Frank and Penelope','movie',1),(920143,'https://image.tmdb.org/t/p/original/svVppV4UOQw1fVi1Dt6z7n2UlyG.jpg','Comedy','El paseo 6','The last year High School excursion is the walk where anything can happen, but the last year High School excursion with the parents, that is the last straw. And since Álvaro Castaño knows that security is better than the police, he decides to travel with his family to watch over his daughter Sarita, however, his mother-in-law, Raquel, is not willing to allow it and also embarks in the plan . On the paradisiacal beaches of San Andrés, Álvaro Castaño will become Sara\'s nightmare and the sensation for the excursion, while his sexy mother-in-law of him will be the one to steal the show. El Paseo 6, the last yeat High School excursion, because the luck of the grandmother, the High School girls wish it.','https://image.tmdb.org/t/p/original/5vSFW0rxMDZg8j5cr0JICBDSrGM.jpg','2021-12-25','The Trip 6','movie',4),(928769,'https://image.tmdb.org/t/p/original/AfWtIzrdB0HMQ0Swequza4Jo1Kh.jpg','Comedy, Romance, Sci-Fi & Fantasy','เอไอหัวใจโอเวอร์โหลด','A modern love story set in the near future where an AI building is powered by human feelings. Due to a software glitch, it falls in love with a real girl, escapes the building into the body of a real man, and tries to win her affections.','https://image.tmdb.org/t/p/original/sBiJOvHCSWORnFpc4yItflIkdTi.jpg','2022-02-15','AI Love You','movie',6),(934433,'https://image.tmdb.org/t/p/original/44immBwzhDVyjn87b3x3l9mlhAD.jpg','Horror, Mystery, Thriller','Scream VI','Following the latest Ghostface killings, the four survivors leave Woodsboro behind and start a fresh chapter.','https://image.tmdb.org/t/p/original/wDWwtvkRRlgTiUr6TyLSMX8FCuZ.jpg','2023-03-08','Scream VI','movie',7),(948713,'https://image.tmdb.org/t/p/original/xwA90BwZXTh8ke3CVsQlj8EOkFr.jpg','Action & Adventure, Action & Adventure, History, Drama, War','The Last Kingdom: Seven Kings Must Die','In the wake of King Edward\'s death, Uhtred of Bebbanburg and his comrades adventure across a fractured kingdom in the hopes of uniting England at last.','https://image.tmdb.org/t/p/original/7yyFEsuaLGTPul5UkHc5BhXnQ0k.jpg','2023-04-14','The Last Kingdom: Seven Kings Must Die','movie',2),(985939,'https://image.tmdb.org/t/p/original/hlxduUs8y9icWGMzYCDLcYHEQ2u.jpg','Thriller','Fall','For best friends Becky and Hunter, life is all about conquering fears and pushing limits. But after they climb 2,000 feet to the top of a remote, abandoned radio tower, they find themselves stranded with no way down. Now Becky and Hunter’s expert climbing skills will be put to the ultimate test as they desperately fight to survive the elements, a lack of supplies, and vertigo-inducing heights','https://image.tmdb.org/t/p/original/v28T5F1IygM8vXWZIycfNEm3xcL.jpg','2022-08-11','Fall','movie',6),(998771,'https://image.tmdb.org/t/p/original/4EoQnShuyQl2YawXlQmQXn4CalG.jpg','Comedy','Si Saben Como me pongo Pa Que Me Invitan? 2','The El Encanto resort once again hosts a retreat for four couples -- including a liar, a sex addict and a thief -- seeking to fix their relationships.','https://image.tmdb.org/t/p/original/bFRxPAiyA7dhTLrEcitAjLL02BJ.jpg','2022-07-13','Si Saben Como me pongo Pa Que Me Invitan? 2','movie',5),(1013860,'https://image.tmdb.org/t/p/original/kmzppWh7ljL6K9fXW72bPN3gKwu.jpg','Action & Adventure, Comedy, Sci-Fi & Fantasy, Crime','R.I.P.D. 2: Rise of the Damned','When Sheriff Roy Pulsipher finds himself in the afterlife, he joins a special police force and returns to Earth to save humanity from the undead.','https://image.tmdb.org/t/p/original/g4yJTzMtOBUTAR2Qnmj8TYIcFVq.jpg','2022-11-15','R.I.P.D. 2: Rise of the Damned','movie',1),(1023803,'https://image.tmdb.org/t/p/original/3t0DcVPuW9JRtc1CWnh1ktCKrrO.jpg','Music','The Hip Hop Nutcracker','Features Rev Run as he brings audiences on a hip-hop reimagining of The Nutcracker ballet set in NYC.','https://image.tmdb.org/t/p/original/iqOGxcKViTtU7pwC24xUb1bDslw.jpg','2022-11-25','The Hip Hop Nutcracker','movie',4),(1102776,'https://image.tmdb.org/t/p/original/zh614Bixv2ePaHK8gzcUpUmcvYv.jpg','Thriller, Action & Adventure, Crime','AKA','A steely special ops agent finds his morality put to the test when he infiltrates a crime syndicate and unexpectedly bonds with the boss\' young son.','https://image.tmdb.org/t/p/original/3BSxAjiporlwQTWzaHZ9Yrl5C9D.jpg','2023-04-28','AKA','movie',4),(1114905,'https://image.tmdb.org/t/p/original/a20Z41sNEqhBOf6addlSBTTQJkg.jpg','Thriller, Mystery, Drama, Horror','Uno para morir','Seven strangers wake up in a mansion in the middle of nowhere to discover they are part of a twisted game. They will have 60 minutes to choose one person to die; otherwise, all of them will be murdered. As the clock ticks down, the most lurid secrets will come to light, and they’ll discover they are all connected by a dark past.','https://image.tmdb.org/t/p/original/yMeKoe3ui4Pad8FUOJwCby3SOWe.jpg','2023-05-05','Death\'s Roulette','movie',2),(38019227,'/static/img/default_bg_image.jpg','Non spécifié','Film Test','Aucun','/static/img/default_poster.jpg','2023-01-01','Film Test','movie',1);
/*!40000 ALTER TABLE `MoviesAPI` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `MoviesAPI_Backdrop_Path_Trigger` BEFORE INSERT ON `MoviesAPI` FOR EACH ROW BEGIN
    IF NEW.backdrop_path IS NULL THEN
        SET NEW.backdrop_path = '/static/img/default_bg_image.jpeg';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Seance`
--

DROP TABLE IF EXISTS `Seance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Seance` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_Movie` int DEFAULT NULL,
  `ID_Cinema` int DEFAULT NULL,
  `HeureDebut` time DEFAULT NULL,
  `Date` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_Movie` (`ID_Movie`),
  KEY `ID_Cinema` (`ID_Cinema`),
  CONSTRAINT `Seance_ibfk_1` FOREIGN KEY (`ID_Movie`) REFERENCES `Movie` (`ID`),
  CONSTRAINT `Seance_ibfk_2` FOREIGN KEY (`ID_Cinema`) REFERENCES `Cinema` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Seance`
--

LOCK TABLES `Seance` WRITE;
/*!40000 ALTER TABLE `Seance` DISABLE KEYS */;
INSERT INTO `Seance` VALUES (1,4,1,'15:30:00','2023-01-01'),(2,4,1,'18:00:00','2023-01-01'),(3,4,1,'21:00:00','2023-01-01'),(4,4,2,'13:00:00','2023-01-01'),(5,4,2,'16:00:00','2023-01-01'),(6,4,2,'19:00:00','2023-01-01'),(7,8,1,'17:00:00','2023-01-02');
/*!40000 ALTER TABLE `Seance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Session`
--

DROP TABLE IF EXISTS `Session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Session` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_Cinema` int DEFAULT NULL,
  `Cle` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_Cinema` (`ID_Cinema`),
  CONSTRAINT `Session_ibfk_1` FOREIGN KEY (`ID_Cinema`) REFERENCES `Cinema` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Session`
--

LOCK TABLES `Session` WRITE;
/*!40000 ALTER TABLE `Session` DISABLE KEYS */;
INSERT INTO `Session` VALUES (9,1,'root'),(10,2,'root'),(11,3,'root'),(12,4,'root'),(13,5,'root'),(14,6,'root'),(15,7,'root');
/*!40000 ALTER TABLE `Session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-02 17:21:22
