(** Color abstraction for our window manager.
    Can provide back and forth operations with RGB and internal representations
*)

open Base

(*Int.t est un type de données intégré qui représente un entier
* signé de taille variable*)
type t = Int.t [@@deriving show]


(*L'implémentation de la fonction from_rgb utilise les opérations bit à bit pour concaténer les trois composantes de couleur en une valeur entière unique qui représente la couleur RGB. Les opérations de décalage de bits (lsl) sont utilisées pour positionner les bits de chaque composante à la position appropriée dans le nombre entier final, tandis que l'opération logique OR (lor) est utilisée pour combiner les trois composantes en une seule valeur.

La fonction interval est utilisée pour s'assurer que les valeurs des composantes de couleur sont dans la plage [0; 255]. Si une valeur de composante est supérieure à 255, elle est réduite à 255, et si elle est inférieure à 0, elle est augmentée à 0. Cette étape est importante pour garantir que les valeurs de couleur générées sont valides et ne dépassent pas les limites du modèle de couleur RGB.

La valeur de retour est un entier signé t représentant la couleur RGB générée à partir des valeurs des composantes rouges, vertes et bleues fournies en entrée.*)
let from_rgb r g b = 
  let interval x = max 0 (min 255 x) in 
  let r = interval r and g = interval g and b = interval b in 
  (r lsl 16) lor (g lsl 8) lor b
;;

(*Pour décomposer un nombre entier représentant une couleur RGB en ses composantes rouges, vertes et bleues, nous allons utiliser les opérations bit à bit pour extraire chaque composante individuellement.
Cette implémentation utilise les opérations de décalage de bits (lsr et land) pour extraire les bits de chaque composante de couleur à partir de l'entier signé représentant la couleur.

L'opération lsr (shift right) est utilisée pour décaler les bits de la composante de couleur désirée vers le côté droit de l'entier, de manière à ce que les bits de la composante soient situés dans les 8 bits les plus faibles. Ensuite, l'opération land (logical and) est utilisée pour masquer tous les bits de l'entier à l'exception des 8 bits les plus faibles, qui représentent la valeur de la composante de couleur extraite.

Les trois composantes de couleur extraites sont ensuite retournées sous forme de triplet d'entiers (r, g, b) dans l'ordre rouge-vert-bleu.*)

let to_rgb t = 
  let r = (t lsr 16) land 255
  and g = (t lsr 8) land 255
  and b = t land 255 in
  (r,g,b);;

let to_int t  = t;;

let inverse t = 
  let (r,g,b) = to_rgb t in
  let new_r = 255 - r in
  let new_g = 255 - g in
  let new_b = 255 - b in
  from_rgb new_r new_b new_g;;

let random () = 
  let r = Random.int 255 in
  let g = Random.int 255 in
  let b = Random.int 255 in
  from_rgb r g b;;


(** add 2 color component-wise: *)
(** the result is a valid color  *)
(* Comme les composantes sont des entiers compris entre 0 et 255, l'addition doit être réalisée modulo 256 pour garantir que la nouvelle couleur obtenue reste une couleur valide. *)
let (+) c1 c2 = 
  let (r1, g1, b1) = to_rgb c1 in
  let (r2, g2, b2) = to_rgb c2 in
  let r = (r1 + r2) mod 256 in
  let g = (g1 + g2) mod 256 in
  let b = (b1 + b2) mod 256 in
  from_rgb r g b;;


let white = from_rgb 255 255 255;;
let black = from_rgb 0 0 0;;
let red   = from_rgb 255 0 0;;
let green = from_rgb 0 255 0;;
let blue  = from_rgb 0 0 255;;


(** TESTS MUST BE RUN WITH "dune runtest"*)
let%test "idint" =
  let c = random () in
  to_int c = c

let%test "idrgb" =
  let c = random () in
  let (r,g,b) = to_rgb c in
  from_rgb  r g b = c

let%test "white" =
  let (r,g,b) = to_rgb white in
  (r = 255) && (g=255) && (b=255)

let%test "black/white" = white = inverse black

let%test "whitecolors" = (red + green + blue) = white

let%test "addwhite" =
  white = white + white
