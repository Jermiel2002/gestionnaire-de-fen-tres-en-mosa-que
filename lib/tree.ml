open Base

type ('v, 'w) t =
  | Node of 'v * ('v,'w) t * ('v,'w) t
  | Leaf of 'w [@@deriving show]

let return w = assert false

let combine v l1 l2 = assert false

let%test "n" =
  let l1 = return 1 in
  let l2 = return 2 in
  let l3 = return 3 in
  let n1 = combine 4 l1 l2 in
  let n2 = combine 5 n1 l3 in
  Stdlib.(n2 = (Node(5,Node(4, Leaf 1, Leaf 2), Leaf 3)))

let is_leaf = assert false

let%test "leaf1" = is_leaf (Leaf 1)
let%test "leaf2" = is_leaf (Node (1, Leaf 1, Leaf 1)) |> not



let get_leaf_data = assert false

let%test "gld1" =  match get_leaf_data (Leaf 1) with
  | None -> false
  | Some o -> Int.(o = 1)


let%test "gld2" = match get_leaf_data (Node (1, Leaf 2, Leaf 3)) with
  | None -> true
  | _ -> false


let get_node_data = assert false

let%test "gnd1" =  match get_node_data (Leaf 1) with
  | None -> true
  | _ -> false


let%test "gnd2" = match get_node_data (Node (1, Leaf 2, Leaf 3)) with
  | None -> false
  | Some o -> Int.(o = 1)


let map (f,g) d = assert false

let%test "map" =
  let l1 = return 1 in
  let l2 = return 2 in
  let l3 = return 3 in
  let n1 = combine "four" l1 l2 in
  let n2 = combine "five" n1 l3 in
  let g x = x * 2 in
  let f x = x ^ x in
  let n3 = map (f,g) n2 in
  Stdlib.(n3 = (Node("fivefive",Node("fourfour", Leaf 2, Leaf 4), Leaf 6)))


let iter (f,g) d = assert false


type ('v, 'w) z = TZ of ('v,'w) context * ('v,'w) t
and ('v,'w) context =
  | Top
  | LNContext of 'v * ('v,'w) context * ('v,'w) t
  | RNContext of ('v,'w) t * 'v * ('v,'w) context [@@deriving show]



let from_tree d = assert false



let change z s = assert false

let change_up z v = assert false


let go_down z = assert false

let%test "gd1" =
  let l1 = return 1 in
  let l2 = return 2 in
  let l3 = return 3 in
  let n1 = combine "four" l1 l2 in
  let n2 = combine "five" n1 l3 in
  let z = from_tree n2 in
  match go_down z with
  | Some z' -> Stdlib.(z' = TZ (LNContext ("five", Top,Leaf 3),Node("four", Leaf 1, Leaf 2)))
  | None -> false

let%test "gd2" =
  let l1 = return 1 in
  let l2 = return 2 in
  let l3 = return 3 in
  let n1 = combine "four" l1 l2 in
  let n2 = combine "five" n1 l3 in
  let z = from_tree n2 in
  match Option.(Some z >>= go_down >>= go_down) with
  | Some z' -> Stdlib.(z' = TZ(LNContext("four", LNContext ("five", Top,Leaf 3), Leaf 2), Leaf 1))
  | None -> false


let%test "gd3" =
  let l1 = return 1 in
  let l2 = return 2 in
  let l3 = return 3 in
  let n1 = combine "four" l1 l2 in
  let n2 = combine "five" n1 l3 in
  let z = from_tree n2 in
  match Option.(Some z >>= go_down >>= go_down >>= go_down) with
  | Some _ -> false
  | None -> true

let go_up z = assert false

let%test "gu1" =
  let z = TZ(RNContext(Leaf 1, "four", LNContext ("five", Top,Leaf 3)), Leaf 2) in
  match go_up z with
  | Some z' -> Stdlib.(z' = TZ (LNContext ("five", Top,Leaf 3),Node("four", Leaf 1, Leaf 2)))
  | None -> false

let%test "gu2" =
  let z = TZ(RNContext(Leaf 1, "four", LNContext ("five", Top,Leaf 3)), Leaf 2) in
  match Option.(Some z >>= go_up >>= go_up) with
  | Some z' -> Stdlib.(z' = TZ( Top,  Node("five",Node("four", Leaf 1, Leaf 2), Leaf 3)))
  | None -> false

let%test "gu3" =
  let z = TZ(RNContext(Leaf 1, "four", LNContext ("five", Top,Leaf 3)), Leaf 2) in
  match Option.(Some z >>= go_up >>= go_up >>= go_up) with
  | Some _  -> false
  | None -> true

let go_left z = assert false

let%test "gl1" =
  let z = TZ(RNContext(Leaf 1, "four", LNContext ("five", Top,Leaf 3)), Leaf 2) in
  match go_left z with
  | Some z' -> Stdlib.(z' = TZ(LNContext("four", LNContext ("five", Top,Leaf 3), Leaf 2), Leaf 1))
  | None -> false

let%test "gl2" =
  let z = TZ(LNContext("four", LNContext ("five", Top,Leaf 3), Leaf 2), Leaf 1) in
  match go_left z with
  | Some _ -> false
  | None -> true

let go_right z = assert false


let%test "gr1" =
  let z = TZ(LNContext("four", LNContext ("five", Top,Leaf 3), Leaf 2), Leaf 1) in
  match go_right z with
  | Some z' -> Stdlib.(z' = TZ(RNContext(Leaf 1, "four", LNContext ("five", Top,Leaf 3)), Leaf 2))
  | None -> false

let%test "gl2" =
  let z = TZ(RNContext(Leaf 1, "four", LNContext ("five", Top,Leaf 3)), Leaf 2) in
  match go_right z with
  | Some _ -> false
  | None -> true


let reflexive_transitive f d = assert false

let%test "rf1" =
  let z = TZ(RNContext(Leaf 1, "four", LNContext ("five", Top,Leaf 3)), Leaf 2) in
  Stdlib.(reflexive_transitive go_up z = TZ( Top,  Node("five",Node("four", Leaf 1, Leaf 2), Leaf 3)))

let%test "rf2" =
  let z =   TZ(LNContext("four", LNContext ("five", Top,Leaf 3), Leaf 2), Leaf 1) in
  Stdlib.(reflexive_transitive go_up z = TZ( Top,  Node("five",Node("four", Leaf 1, Leaf 2), Leaf 3)))


let%test "rf3" =
  let z = TZ( Top,  Node("five",Node("four", Leaf 1, Leaf 2), Leaf 3)) in
  Stdlib.(reflexive_transitive go_up z = z)

let focus_first_leaf t = assert false


let%test "ffl1" =
  let t = Node("five",Node("four", Leaf 1, Leaf 2), Leaf 3) in
  Stdlib.(focus_first_leaf t = TZ(LNContext("four", LNContext ("five", Top,Leaf 3), Leaf 2), Leaf 1))


let remove_leaf z = assert false


let%test "rl1" =
  let z = TZ(LNContext("four", LNContext ("five", Top,Leaf 3), Leaf 2), Leaf 1) in
  match remove_leaf z with
  | None -> false
  | Some (z, v) -> Stdlib.((z = TZ (LNContext ("five", Top, Leaf 3), Leaf 2)) && (v="four"))


let%test "rl2" =
  let z = TZ (LNContext ("five", Top,Leaf 3),Node("four", Leaf 1, Leaf 2)) in
  match remove_leaf z with
  | None -> true
  | _ -> false


let is_left_context  z = assert false
let is_right_context z = assert false
let is_top_context   z = assert false

let rec move_until f p z = assert false


let%test "mv1" =
  let z = TZ(LNContext("four", LNContext ("five", Top,Leaf 3), Leaf 2), Leaf 1) in
  let p = fun (TZ(_,s)) -> match get_node_data s with | None -> false | Some v -> String.(v = "five") in
  match move_until go_up p z with
  | None -> false
  | Some z -> Stdlib.(z = TZ( Top,  Node("five",Node("four", Leaf 1, Leaf 2), Leaf 3)))

let%test "mv2" =
  let z = TZ(LNContext("four", LNContext ("five", Top,Leaf 3), Leaf 2), Leaf 1) in
  let p = fun (TZ(_,s)) -> match get_node_data s with | None -> false | Some v -> String.(v = "four") in
  match move_until go_up p z with
  | None -> false
  | Some z -> Stdlib.(z = TZ (LNContext ("five", Top,Leaf 3),Node("four", Leaf 1, Leaf 2)))



let next_leaf z = assert false

let%test "nl1" =
  let z = TZ(LNContext("four", LNContext ("five", Top,Leaf 3), Leaf 2), Leaf 1) in
  match next_leaf z with
  | None -> false
  | Some z -> Stdlib.(z = TZ(RNContext(Leaf 1, "four", LNContext ("five", Top,Leaf 3)), Leaf 2))

let%test "nl2" =
  let z = TZ(LNContext("four", LNContext ("five", Top,Leaf 3), Leaf 2), Leaf 1) in
  match Option.(Some z >>= next_leaf >>= next_leaf) with
  | None -> false
  | Some z -> Stdlib.(z = TZ (RNContext (Node ("four", Leaf 1, Leaf 2), "five", Top), Leaf 3))


let%test "nl3" =
  let z = TZ(LNContext("four", LNContext ("five", Top,Leaf 3), Leaf 2), Leaf 1) in
  match Option.(Some z >>= next_leaf >>= next_leaf >>= next_leaf) with
  | None -> true
  | _ -> false


let previous_leaf z = assert false

let%test "pl1" =
  let z = TZ (RNContext (Node ("four", Leaf 1, Leaf 2), "five", Top), Leaf 3) in
  match previous_leaf z with
  | None -> false
  | Some z -> Stdlib.(z = TZ(RNContext(Leaf 1, "four", LNContext ("five", Top,Leaf 3)), Leaf 2))

let%test "pl2" =
  let z = TZ (RNContext (Node ("four", Leaf 1, Leaf 2), "five", Top), Leaf 3) in
  match Option.(Some z >>= previous_leaf >>= previous_leaf) with
  | None -> false
  | Some z -> Stdlib.(z = TZ(LNContext("four", LNContext ("five", Top,Leaf 3), Leaf 2), Leaf 1))


let%test "pl3" =
  let z = TZ (RNContext (Node ("four", Leaf 1, Leaf 2), "five", Top), Leaf 3) in
  match Option.(Some z >>= previous_leaf >>= previous_leaf >>= previous_leaf) with
  | None -> true
  | _ -> false
