
/*Exercice 1 : base hotel*/

--1)Afficher la liste des hôtels avec leur station.
CREATE VIEW v_hotels_station
AS
SELECT * FROM hotel,station
WHERE hot_sta_id=sta_id

--2)Afficher la liste des chambres et leur hôtel
CREATE VIEW v_hotels_chambre
AS
SELECT * FROM hotel,chambre
WHERE hot_id=cha_hot_id

--3)Afficher la liste des réservations avec le nom des clients
CREATE VIEW v_reserv_client
AS 
SELECT * FROM reservation,client
WHERE res_cli_id=cli_id

--4)Afficher la liste des chambres avec le nom de l'hôtel et le nom de la station
CREATE VIEW v_cha_hotel_station
AS
SELECT cha_id,cha_hot_id,cha_numero,cha_capacite,cha_type,hot_nom,sta_nom 
FROM chambre,hotel,station
WHERE hotel.hot_sta_id=station.sta_id 
AND hotel.hot_id=chambre.cha_hot_id


--5)Afficher les réservations avec le nom du client et le nom de l'hôtel
CREATE VIEW v_reserv_hotel_client
AS
SELECT res_id, res_cha_id, res_cli_id, res_date, res_date_debut, res_date_fin, res_prix, res_arrhes, cli_nom, hot_nom 
FROM reservation, hotel, client, chambre
WHERE client.cli_id = reservation.res_cli_id 
AND reservation.res_cha_id = chambre.cha_id 
AND chambre.cha_hot_id = hotel.hot_id

/*Exercice 2 : base gescom*/
--Réalisez les vues suivantes à partir de la base gescom.

--v_Details correspondant à la requête : _A partir de la table orders_details, afficher par code produit, 
--la somme des quantités commandées et le prix total correspondant : on nommera la colonne correspondant à la somme des quantités commandées, QteTot et le prix total, PrixTot.