// Data query :
// vous devez définir les requêtes neo4j permettant de répondre aux besoins suivants :
//1. Donner le nombre de nœuds par label;
//2. Donner le nombre de relations par type;
//3. Donner la ou les catégories du restaurant 8th & Union Kitchen;
//4. Donner la ou les ambiances du restaurant 8th & Union Kitchen;
//5. Donner les reviews du restaurant Tokyo Sushi;
//6. Donner les couples d’utilisateurs amis qui ont reviewé le restaurant Tokyo Sushi;
//7. Qui est l’utilisateur qui a le plus d’amis ?
//8. Qui sont les amis des reviewers du restaurant Tokyo Sushi qui ont reviewés des restaurants avec les mêmes ambiances ?
//9. Combien de paires de personnes ont au moins 10 restaurants aimés en commun ? (un restaurant est ’aimé’ si la review a une note (stars) >= 4) 

//================================================================================//

//visualisation :
# MATCH (n:user)
# RETURN count(*)
# import image module

# MATCH (n:restaurant)
# RETURN count(*)

//Q1
# MATCH (u:user)-[r:friend]->(v:user)
# RETURN count(*)

//Q2
# MATCH (u:user)-[r:review]->(n:restaurant)
# RETURN count(*)

//Q3
# match (r:restaurant)
# where r.name='8th & Union Kitchen'
# return r.categories

//Q4
# match (r:restaurant)
# where r.name='8th & Union Kitchen'
# return r.Ambiences

//Q5
# MATCH (n:restaurant{name:'Tokyo Sushi'})<-[r:review]-(user)
# RETURN r

//pour afficher le nombre de review:
# MATCH (n:restaurant{name:'Tokyo Sushi'})<-[r:review]-(user)
# RETURN count(*)

//Q6
# match (u:user)-[:review]->(r:restaurant{name:'Tokyo Sushi'})<-[:review]-(v:user), 
# (u:user)-[:friend]->(v:user), 
# (u:user)<-[:friend]-(v:user)
# return distinct u.name,v.name

//Q7
# match (u:user)
# return u.name,u.nb_friends
# order by u.nb_friends desc
# limit 1


//Q8
# match (u:user)-[r:review]->(n:restaurant{name: 'Tokyo Sushi'}),
# (u2:user)-[:friend]->(u:user), 
# (u2:user)-[:review]->(n2:restaurant)
# where n.Ambiences = n2.Ambiences
# return distinct u2.name,u.name

//Q9
# match (u:user)-[ru:review]->(r:restaurant)<-[rv:review]-(v:user)
# WITH count(r) as restau, count(ru.stars) as a, count(rv.stars) as b, u.name as name_user1, v.name as name_user2
# where a>=4 and b>=4 and mm>=10
# return distinct count(*) as common_numbername_user1
# // return count(*) as N_of_common_likes_10