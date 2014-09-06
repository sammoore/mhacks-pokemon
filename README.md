
Repo Examples

https://github.com/mcdonamp/smorgasbord/tree/master/Mobile/ShortOrder/ShortOrder

https://github.com/mcdonamp/smorgasbord/blob/master/Firebase/Buzzword/Buzzword/FBZLoginViewController.h

THE GAME PLAN
--------------

Root
 Users
 $userid
 user metadata : {etc.}
 User Pokedex
 $userid
 $pokemonid
 Pokemon
 $pokemonid
 name:
 type:
 level:
 Geofire
 User_Locations
 $userid
 lat:
 long:
 Pokemon_Locations
 $userid
 lat:

Maps API, GPS
Tableviews for my pokedex, trainers in the area (in a certain geofence), map
Add background task for fetching GPS, run geoquery, kick off local notification

--Mike

--
Michael McDonald
Solutions Architect | Firebase
mcdonald@firebase.com
(510) 225-8455
@asciimike @firebase
