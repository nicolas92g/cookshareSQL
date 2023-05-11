CREATE TABLE CLIENT(
   id INT PRIMARY KEY,
   mail VARCHAR(50) NOT NULL,
   bannis NUMBER(1) DEFAULT 0 NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   nom VARCHAR(50) NOT NULL,
   ville VARCHAR(50),
   codePostal VARCHAR(5),
   dateAnniversaire DATE,
   pays VARCHAR(50),
   nomDeVoie VARCHAR(50),
   numeroDeVoie INT,
   typeDeVoie VARCHAR(50),
   parraine INT REFERENCES CLIENT(id)
);

CREATE TABLE LIVREUR(
   id INT PRIMARY KEY,
   zoneLivraison VARCHAR(50),
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   dateDeNaissance DATE NOT NULL,
   pays VARCHAR(50),
   ville VARCHAR(50),
   codePostal VARCHAR(5),
   numeroDeVoie INT,
   nomDeVoie VARCHAR(50),
   typeDeVoie VARCHAR(50),
   typePermis VARCHAR(2) NOT NULL,
   dateObtentionPermis DATE NOT NULL,
   dateExpirationPermis VARCHAR(50) NOT NULL
);

CREATE TABLE ADDRESSE(
   id INT PRIMARY KEY,
   pays VARCHAR(50) NOT NULL,
   ville VARCHAR(50) NOT NULL,
   codePostal VARCHAR(5) NOT NULL,
   numeroDeVoie INT NOT NULL,
   typeDeVoie VARCHAR(50) NOT NULL,
   nomDeVoie VARCHAR(50) NOT NULL,
   client INT REFERENCES CLIENT(id) NOT NULL
);

CREATE TABLE RESTAURANT(
   id INT PRIMARY KEY,
   descriptif CLOB NOT NULL,
   typeCuisine VARCHAR(50) NOT NULL,
   administrateur INT REFERENCES CLIENT(id) NOT NULL
);

CREATE TABLE INGREDIENT(
   id INT PRIMARY KEY,
   nom VARCHAR(50) NOT NULL,
   allergene NUMBER(1) DEFAULT 0 NOT NULL
);

CREATE TABLE INCIDENT(
   id INT PRIMARY KEY,
   dateIncident DATE NOT NULL,
   descriptif CLOB NOT NULL,
   pays VARCHAR(50),
   ville VARCHAR(50),
   codePostal VARCHAR(50),
   numeroDeVoie VARCHAR(50),
   TypeDeVoie VARCHAR(50),
   nomDeVoie VARCHAR(50),
   livreur INT REFERENCES LIVREUR(id) NOT NULL
);

CREATE TABLE VISITEMEDICAL(
   id INT PRIMARY KEY,
   dateDePassage DATE NOT NULL,
   livreur INT REFERENCES LIVREUR(id) NOT NULL
);

CREATE TABLE FORMULE(
   id INT PRIMARY KEY,
   prix VARCHAR(50) NOT NULL,
   nom VARCHAR(50) NOT NULL,
   debutPeriodeValidite DATE,
   finPeriodeValidite DATE,
   restaurant INT REFERENCES RESTAURANT(id) NOT NULL
);

CREATE TABLE PLAT(
   id INT PRIMARY KEY,
   description CLOB NOT NULL,
   restaurant INT REFERENCES RESTAURANT(id) NOT NULL
);

CREATE TABLE PHOTO(
   id INT PRIMARY KEY,
   chemin VARCHAR(100) NOT NULL,
   description VARCHAR(255),
   restaurant INT REFERENCES RESTAURANT(id),
   plat INT REFERENCES PLAT(id)
);

CREATE TABLE COMMANDE(
   id INT PRIMARY KEY ,
   horaireLivraison TIMESTAMP,
   prix NUMBER(5, 2) NOT NULL,
   addresse INT REFERENCES ADDRESSE(id) NOT NULL,
   livreur INT REFERENCES LIVREUR(id) NOT NULL,
   distance INT
);

CREATE TABLE FACTURE(
   idTransaction VARCHAR(50) PRIMARY KEY,
   modePaiement VARCHAR(50) NOT NULL,
   commande INT REFERENCES COMMANDE(id) NOT NULL UNIQUE
);

CREATE TABLE AVOIR(
   id INT PRIMARY KEY,
   montant NUMBER(5, 2) NOT NULL,
   actif NUMBER(1) DEFAULT 1 NOT NULL,
   facture VARCHAR(50) REFERENCES FACTURE(idTransaction) NOT NULL,
   client INT REFERENCES CLIENT(id) NOT NULL
);

CREATE TABLE concerne(
   plat INT REFERENCES PLAT(id),
   commande INT REFERENCES COMMANDE(id),
   quantite INT NOT NULL,
   PRIMARY KEY(plat, commande)
);

CREATE TABLE prend(
   client INT REFERENCES CLIENT(id),
   commande INT REFERENCES COMMANDE(id),
   PRIMARY KEY(client, commande)
);

CREATE TABLE contient(
   plat INT REFERENCES PLAT(id),
   ingredient INT REFERENCES INGREDIENT(id),
   PRIMARY KEY(plat, ingredient)
);

CREATE TABLE comprend(
   plat INT REFERENCES PLAT(id),
   formule INT REFERENCES FORMULE(id),
   PRIMARY KEY(plat, formule)
);

CREATE TABLE note(
   client INT REFERENCES CLIENT(id),
   plat INT REFERENCES PLAT(id),
   valeur INT NOT NULL,
   PRIMARY KEY(client, plat)
);

CREATE TABLE paye(
   client INT REFERENCES CLIENT(id),
   facture VARCHAR(50) REFERENCES FACTURE(idTransaction),
   montant NUMBER(5,2) NOT NULL,
   PRIMARY KEY(client, facture)
);

