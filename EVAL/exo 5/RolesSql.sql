/*création des utilisateurs*/

CREATE USER 'Pierre'@'%' IDENTIFIED BY 'mdp';
CREATE USER 'Paul'@'%' IDENTIFIED BY 'mdp';
CREATE USER 'Jacky'@'%' IDENTIFIED BY 'mdp';
CREATE USER 'Michel'@'%' IDENTIFIED BY 'mdp';

/*création du groupe marketing*/

CREATE ROLE marketing;

/*attribution des roles par base*/
GRANT SELECT, UPDATE, DELETE, INSERT ON gescom_afpa.categories TO marketing
GRANT SELECT, UPDATE, DELETE, INSERT ON gescom_afpa.orders TO marketing
GRANT SELECT, UPDATE, DELETE, INSERT ON gescom_afpa.orders_details TO marketing  
GRANT SELECT, UPDATE, DELETE, INSERT ON gescom_afpa.products TO marketing  
GRANT SELECT, UPDATE, DELETE, INSERT ON gescom_afpa.customers TO marketing


/*attribution du role au utilisateur*/
GRANT marketing TO Pierre, Paul, Jacky, Michel;