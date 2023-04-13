(** Color abstraction for our window manager.
    Can provide back and forth operations with RGB and internal representations
*)

open Base

type t = Int.t [@@deriving show]

let from_rgb r g b = assert false

let to_rgb t = assert false

let to_int t  = t

let inverse t = assert false

let random () = assert false


(** add 2 color component-wise: *)
(** the result is a valid color  *)
let (+) c1 c2 = assert false

let white = assert false
let black = assert false
let red   = assert false
let green = assert false
let blue  = assert false


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
