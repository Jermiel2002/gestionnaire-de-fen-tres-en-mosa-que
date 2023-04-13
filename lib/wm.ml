
type direction = Vertical | Horizontal [@@deriving show]
type window = Win of string * Color.t [@@deriving show]


type coordinate = Coord of {px: int; py: int; sx: int; sy: int} [@@deriving show]
type split = Split of direction * float (* ratio between 0 and 1 *) [@@deriving show]


let draw_win w coord bc = assert false

type wmtree = ((split * coordinate), (window * coordinate)) Tree.t [@@deriving show]
type wmzipper = ((split * coordinate), (window * coordinate)) Tree.z [@@deriving show]

let get_coord wt = assert false

let change_coord wt = assert false

let draw_wmtree bc wt = assert false

let draw_wmzipper bc wz = assert false

let update_coord c t = assert false
