# Commentaires étape par étape du projet

---

## Qu'est ce qu'un **gestionnaire de fenêtres**?
c'est un logiciel qui permet d'afficher et d'organiser le placement des fenêtres des
différentes applications. Il permet aussi de redimensionner les fenêtres, de les
réduire ou de maximiser l'une d'elles qui occupe alors tout l'écran

---

## Important
+ Dans le cas des gestionnaires en mosaïque, les fenêtres ne se superposent pas mais se *juxtaposent*
+ Les fenêtres d'un bureau seront organiser comme les feuilles d'un *arbre binaire*
+ Chaque *noeud interne* est une division de l'espace en deux sous-parties: soit horizontalement, soit verticalement
+ Parmis toutes les fenêtres affichées, l'une d'entre elles est distinguée C'est la fenêtre active: celle qui a *le focus*
	1. c'est elle qui reçoit les événements comme les frappes au clavier ou les clics de la souris.
	2. Elle se distingue par sa bordure qui sera d'une couleur différente des autres.
+ Pour représenter cet arbre avec un focus, nous utiliserons *un zipper d'arbre binaire* qui aura comme *curseur* la feuille qui represente la fenêtre active.
+ Nos fenêtres seront dessinés comme des *rectangles colorés*, identifiées chacune par un *nom affichable*, sur un canvas (zone graphique) d'une *taille prédéfinie*
+ On va utiliser la bibliothèque graphics pour gérer l'affichage ainsi que la lecture des frappes clavier.

---
## on travail sur quoi ?
+ les fichiers sont dans le répertoire bin
+ les fichiers mli ne doivent pas être modifier. Les fichiers ml par contre, oui
+ Implémenter d'abord le module Color.
+ Implémenter ensuite le modèle Tree.
+ Et après, le module Wm.
+ Pour finir par le gestionnaire lui-même.
+ On doit implémenter les actions dans la boucle évenementiel du fichier ocamlwm23 en chainant ces fonctions avec *la monade option*
---
## Description de certains modules
+ le fichier tree.ml contient la définition des types génériques pour les arbres et les zippers, ainsi que les fonctions de manipulation usuelles.
+ le fichier Wm spécialise ce type avec des arbres où:
	1. les feuilles contiennent des fenêtres (texte et couleur) avec coordonnées (position et taille).
	2. les noeuds internes contiennent les informations d'une sous-partie de l'écran

---
## Color.ml et Color.mli
+ Dans le .mli, définit un type t opaque qui ne peut être manipulé que par les fonctions définies dans le module, et fournit une fonction d'affichage automatique pour faciliter le débogage et la compréhension du code. L'attribut [@@deriving show] spécifie également qu'une fonction d'affichage automatique pour le type t doit être générée par le compilateur. Cette fonction d'affichage affichera le contenu de la valeur de type t sous forme de chaîne de caractères, ce qui facilitera le débogage et la compréhension du code.	
+ la fonction from_rgb permet de créer un objet de type t à partir de trois valeurs entières qui représentent les composantes RVB d'une couleur dans le modèle de couleur RVB.
+ la fonction to_rgb permet de récupérer les trois composantes RVB d'une couleur encapsulée dans un objet de type t et de les retourner sous forme d'un triplet d'entiers.
+ la fonction to_int permet de transformer un objet de type t, qui encapsule une couleur dans le modèle de couleur RVB, en une valeur numérique qui représente cette couleur sous une forme différente. La nature précise de cette valeur numérique dépend de la méthode de transformation utilisée dans la fonction.
+ la fonction inverse permet de créer un nouvel objet de type t dont les trois composantes RVB sont inversées par rapport à l'objet d'entrée. Cela signifie que pour chaque composante, la valeur dans le nouvel objet est égale à la différence entre 255 et la valeur correspondante dans l'objet d'entrée.
+ La fonction random implémente une méthode pour générer aléatoirement trois valeurs entières, qui représentent les composantes RVB d'une couleur. Ces trois valeurs entières sont utilisées pour créer un nouvel objet de type t, qui encapsule la couleur aléatoire générée.
+ Les cinq variables prédéfinies white, black, red, green et blue permettent d'accéder facilement à des objets de type t qui représentent des couleurs spécifiques.

---
## Tree.ml et Tree.mli
+ Le type ('v, 'w) t : Il s'agit d'une structure de données d'arbre binaire avec deux types de nœuds possibles : les nœuds internes et les feuilles. Les nœuds internes sont représentés à l'aide du constructeur Node et contiennent une valeur de type 'v et deux sous-arbres du même type ('v, 'w) t. Les feuilles sont représentées à l'aide du constructeur Leaf et contiennent une valeur de type 'w.
+ La fonction return prend une valeur w de type 'w en argument et renvoie une feuille de l'arbre binaire contenant cette valeur en utilisant le constructeur Leaf. Le type de retour de la fonction est ('v, 'w) t, ce qui signifie que la feuille créée peut être utilisée dans un arbre binaire de type ('v, 'w) t.
+ La fonction combine prend une valeur de type 'v et deux arbres de type ('v, 'w) t et crée un nouveau noeud contenant la valeur 'v comme donnée de noeud et les deux arbres fournis comme sous-arbres gauche et droit. Elle a pour signature 'v -> ('v, 'w) t -> ('v, 'w) t -> ('v, 'w) t.
+ La fonction is_leaf prend un arbre de type ('v, 'w) t et renvoie true si l'arbre est une feuille et false sinon. Elle a pour signature ('v, 'w) t -> bool.
+ La fonction get_leaf_data prend un arbre de type ('v, 'w) t et renvoie Some w si l'arbre est une feuille contenant la valeur w, et None sinon. Elle a pour signature ('v, 'w) t -> 'w option.
+ La fonction get_node_data prend un arbre de type ('v, 'w) t et renvoie Some v si l'arbre est un noeud contenant la valeur v, et None sinon. Elle a pour signature ('v, 'w) t -> 'v option.
+ La fonction map prend une paire de fonctions de transformation (f, g) ainsi qu'un arbre de type ('v1, 'w1) t. Elle renvoie un nouvel arbre de type ('v2, 'w2) t avec la même structure que l'arbre original, où toutes les données de noeud ont été transformées par la fonction f et toutes les données de feuille ont été transformées par la fonction g. Elle a pour signature (('v1 -> 'v2) * ('w1 -> 'w2)) -> ('v1, 'w1) t -> ('v2, 'w2) t.
+ La fonction iter prend une paire de fonctions (f, g) ainsi qu'un arbre de type ('v, 'w) t. Elle applique la fonction f à toutes les données de noeud de l'arbre et la fonction g à toutes les données de feuille, en utilisant un parcours en préfixe (récursif racine-gauche-droite). Elle a pour signature (('v -> unit) * ('w -> unit)) -> ('v, 'w) t -> unit.
+ Le type ('v, 'w) z représente un zipper sur un arbre binaire, c'est-à-dire une structure qui permet de naviguer efficacement dans l'arbre en conservant une référence à la position courante et à son contexte. Le type ('v, 'w) context représente le contexte de navigation, qui peut être soit la racine de l'arbre, soit un sous-arbre gauche avec son père, soit un sous-arbre droit avec son père.
+ La fonction focus_first_leaf prend un arbre en entrée et renvoie un zipper qui se concentre sur la feuille la plus à gauche de l'arbre.
+ La fonction change  prend un zipper et un sous-arbre en entrée et renvoie un nouveau zipper dans lequel la sous-structure de l'ancien zipper est remplacée par le sous-arbre.
+ La fonction change_up prend un zipper et une valeur en entrée et renvoie un nouveau zipper dans lequel la donnée au-dessus du focus est remplacée par la valeur donnée.
+ La fonction go_down prend un zipper en entrée et renvoie un nouveau zipper où le focus est le sous-arbre le plus à gauche de l'ancien zipper. Il renvoie une option qui peut être vide si l'ancien zipper n'a pas de sous-arbre à gauche.
+ La fonction go_up prend un zipper en entrée et renvoie un nouveau zipper où le focus est la mère du sous-arbre de l'ancien zipper. Il renvoie une option qui peut être vide si l'ancien zipper est déjà à la racine.
+ La fonction go_left prend un zipper en entrée et renvoie un nouveau zipper où le focus est le nœud frère gauche du sous-arbre de l'ancien zipper. Il renvoie une option qui peut être vide si l'ancien zipper n'a pas de frère gauche.
+ La fonction go_right prend un zipper en entrée et renvoie un nouveau zipper où le focus est le nœud frère droit du sous-arbre de l'ancien zipper. Il renvoie une option qui peut être vide si l'ancien zipper n'a pas de frère droit.
+ La fonction reflexive_transitive prend une fonction qui prend un zipper et renvoie un nouveau zipper, ainsi qu'un zipper initial. Elle applique répétitivement la fonction au zipper initial jusqu'à ce qu'elle ne retourne plus rien. Ensuite, elle renvoie le dernier zipper valide avant que la fonction ne retourne plus rien.
+ La fonction move_until prend en entrée deux arguments: une fonction f qui prend un zipper et retourne un zipper optionnellement, et une fonction p qui prend un zipper et retourne un booléen. La fonction move_until applique répétitivement la fonction f au zipper z jusqu'à ce que f retourne None ou jusqu'à ce que la fonction p renvoie true pour le zipper courant. Si la fonction p renvoie true, la fonction move_until retourne le zipper courant, sinon elle retourne None.
+ next_leaf: Cette fonction prend en entrée un zipper z et retourne un zipper optionnel sur la feuille la plus proche à droite du zipper courant. Si le zipper courant est déjà sur la dernière feuille à droite, la fonction next_leaf retourne None.
+ previous_leaf: Cette fonction prend en entrée un zipper z et retourne un zipper optionnel sur la feuille la plus proche à gauche du zipper courant. Si le zipper courant est déjà sur la première feuille à gauche, la fonction previous_leaf retourne None.
+ remove_leaf: Cette fonction prend en entrée un zipper z et retourne une paire optionnelle (z',v) où z' est un zipper qui ressemble à z mais où la sous-structure focalisée est supprimée, et v est la valeur de la mère de la sous-structure focalisée dans z. Si le zipper courant ne focalise pas sur une feuille, la fonction remove_leaf retourne None.
+ is_left_context: Cette fonction prend en entrée un zipper z et retourne un booléen qui est vrai si le focus de z est un sous-arbre gauche.
+ is_right_context: Cette fonction prend en entrée un zipper z et retourne un booléen qui est vrai si le focus de z est un sous-arbre droit.
+ is_top_context: Cette fonction prend en entrée un zipper z et retourne un booléen qui est vrai si le focus de z est la racine de l'arbre.

---
