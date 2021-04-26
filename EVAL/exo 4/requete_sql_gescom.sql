
/*Q1. Afficher dans l'ordre alphabétique et sur une seule colonne les noms et prénoms des employés qui ont des enfants, présenter d'abord ceux qui en ont le plus.*/

SELECT CONCAT (emp_lastname,' ',emp_firstname),emp_children
FROM employees 
ORDER BY  emp_children DESC,emp_lastname,emp_firstname ASC
LIMIT 4

/*Q2. Y-a-t-il des clients étrangers ? Afficher leur nom, prénom et pays de résidence.*/

SELECT cus_lastname,cus_firstname,cus_countries_id
FROM customers
WHERE cus_countries_id NOT LIKE '%FR%'

/*Q3. Afficher par ordre alphabétique les villes de résidence des clients ainsi que le code (ou le nom) du pays.*/

SELECT cus_city,cus_countries_id,cou_name
FROM customers,countries
WHERE cus_countries_id = cou_id
ORDER BY cus_city ASC
LIMIT 5

/*Q4. Afficher le nom des clients dont les fiches ont été modifiées*/

SELECT cus_lastname,cus_update_date
FROM customers
WHERE cus_update_date NOT LIKE 'NULL'

/*Q5. La commerciale Coco Merce veut consulter la fiche d'un client, mais la seule chose dont elle se souvienne est qu'il habite une ville genre 'divos'. Pouvez-vous l'aider ?*/

SELECT*
FROM customers
WHERE cus_city LIKE '%divos%'

/*Q6. Quel est le produit vendu le moins cher ? Afficher le prix, l'id et le nom du produit.*/
SELECT pro_id,pro_name,pro_price
FROM products
ORDER BY pro_price ASC
LIMIT 1

/*Q7. Lister les produits qui n'ont jamais été vendus*/
SELECT DISTINCT pro_id,pro_ref,pro_name
FROM products,orders_details
WHERE pro_id NOT IN
(SELECT ode_pro_id FROM orders_details,products WHERE products.pro_id = orders_details.ode_pro_id)

/*Q8. Afficher les produits commandés par Madame Pikatchien.*/
SELECT pro_id,pro_ref,pro_name,cus_id,ord_id,ode_id
FROM customers
JOIN orders 
ON ord_cus_id = cus_id 
JOIN orders_details
ON ode_ord_id = ord_id
JOIN products
ON pro_id = ode_pro_id
WHERE cus_lastname = "Pikatchien"

/*Q9. Afficher le catalogue des produits par catégorie, le nom des produits et de la catégorie doivent être affichés.*/
SELECT cat_id,cat_name,pro_name
FROM categories,products
WHERE categories.cat_id = products.pro_cat.id
ORDER BY cat_name ASC, pro_name ASC

/*Q10. Afficher l'organigramme hiérarchique (nom et prénom et poste des employés) du magasin de Compiègne, classer par ordre alphabétique. Afficher le nom et prénom des employés*/
SELECT CONCAT( employees.emp_lastname, ' ', employees.emp_firstname ) AS `Employé`, CONCAT( employees_responsable.emp_lastname, ' ', employees_responsable.emp_firstname ) AS `Supérieur` 
FROM employees 
JOIN shops
ON sho_id = emp_sho_id
LEFT JOIN employees employees_responsable 
ON employees_responsable.emp_id = employees.emp_superior_id 
WHERE sho_city ='Compiègne'
ORDER BY employé ASC

/*Q11. Quel produit a été vendu avec la remise la plus élevée ? Afficher le montant de la remise, le numéro et le nom du produit, le numéro de commande et de ligne de commande.*/
SELECT ode_pro_id, ode_ord_id, ode_id, cat_name, pro_name  
FROM orders_details  
JOIN products 
ON pro_id = ode_pro_id 
JOIN categories 
ON cat_id = pro_cat_id 
ORDER BY ode_discount 
DESC LIMIT 1

/*Q13. Combien y-a-t-il de clients canadiens ? Afficher dans une colonne intitulée 'Nb clients Canada'*/

SELECT count(cus_countries_id) AS "NB clients Canada"
FROM customers
WHERE cus_countries_id LIKE "CA"

/*Q14. Afficher le détail des commandes de 2020.*/

SELECT ode_id,ode_unit_price,ode_discount,ode_quantity,ode_ord_id,ode_pro_id,ord_order_date
FROM orders_details
JOIN orders
ON orders_details.ode_ord_id = orders.ord_id

WHERE year(ord_order_date) = '2020'  
ORDER BY `orders_details`.`ode_ord_id` ASC

/*Q15. Afficher les coordonnées des fournisseurs pour lesquels des commandes ont été passées.*/
SELECT DISTINCT sup_name,sup_city,sup_countries_id,sup_zipcode, sup_contact, sup_phone , sup_mail
FROM suppliers,products, orders_details WHERE suppliers.sup_id =products.pro_sup_id
AND pro_id IN
(SELECT ode_pro_id FROM orders_details,products WHERE products.pro_id =orders_details.ode_pro_id)

/*Q16. Quel est le chiffre d'affaires de 2020 ?*/

SELECT    SUM((ode_unit_price-(ode_unit_price*ode_discount/100))*ode_quantity) AS "chiffre d'affaire " ,ord_order_date
FROM orders_details
JOIN orders
ON orders_details.ode_ord_id = orders.ord_id
WHERE year(ord_order_date) = '2020'  

/*Q17. Quel est le panier moyen ?*/
 
SELECT    (SUM(((ode_unit_price-(ode_unit_price*ode_discount/100))*ode_quantity)))/count(DISTINCT(ord_id)) AS 'panier moyen'
FROM orders_details,orders
WHERE orders_details.ode_ord_id = orders.ord_id
 
/*Q18. Lister le total de chaque commande par total décroissant (Afficher numéro de commande, date, total et nom du client).*/

SELECT ord_id, cus_lastname,ord_order_date, CAST(SUM(ode_unit_price - ode_unit_price/100*ode_discount)*ode_quantity AS DECIMAL(7,2)) AS Total
FROM orders
JOIN orders_details ON ode_ord_id = ord_id
JOIN customers ON cus_id = ord_cus_id 
GROUP BY `ord_id`
ORDER BY Total DESC    
LIMIT 10

/*Q19. La version 2020 du produit barb004 s'appelle désormais Camper et, bonne nouvelle, son prix subit une baisse de 10%.*/
UPDATE  products 
SET  pro_price =pro_price - pro_price/100 * 10, pro_name='Camper'  
WHERE pro_ref='barb004'

/*Q20. L'inflation en France en 2019 a été de 1,1%, appliquer cette augmentation à la gamme de parasols.*/
UPDATE products 
SET  pro_price =pro_price + pro_price/100 *(1.1)  
WHERE pro_cat_id = (SELECT cat_id FROM categories WHERE cat_name = "parasols")



/*Q21. Supprimer les produits non vendus de la catégorie "Tondeuses électriques". Vous devez utiliser une sous-requête sans indiquer de valeurs de clés.*/

DELETE p
FROM products p
INNER JOIN `categories` c ON c.cat_id = p.pro_cat_id
WHERE NOT EXISTS(SELECT od.ode_pro_id FROM orders_details od WHERE od.ode_pro_id = p.pro_id  )
AND c.cat_name LIKE "Tondeuses électriques";           
     



  

        
            
    
