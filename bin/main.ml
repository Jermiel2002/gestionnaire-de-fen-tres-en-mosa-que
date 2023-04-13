open Base
open Stdio

open Ocamlwm23


let main () =
  let width = 640 in
  let height = 480 in
  let default_ratio = 0.5 in

  let active_color = Color.white in
  let inactive_color = Color.black in

  (* never increase ration above 0.95 or decrease below 0.05 *)
  let inc_ratio ratio = Float.min 0.95 (ratio +. 0.05) in
  let dec_ratio ratio = Float.max 0.05 (ratio -. 0.05) in

  (* create a new window *)
  let init_win count () =
    let w = Wm.Win("W" ^ (Int.to_string count), Color.random ()) in
    let c = Wm.Coord {px=0; py=0; sx=width;sy=height} in
    Tree.return  (w,c)  |> Tree.focus_first_leaf
  in

  (* create the canvas to draw windows *)
  let f = Printf.sprintf " %dx%d" width height in
  let () = Graphics.open_graph f in


  (* event loop *)
  let rec loop oz count =
    (match oz with
     | None -> Stdio.printf "\nZERO WINDOW\n%!"
     | Some z -> Stdio.printf "\n%s\n%!" (Wm.show_wmzipper z)
    );

    match Graphics.read_key () with
    | 'q' ->
      Stdio.printf "Total number of created windows: %d\nBye\n%!" count;
      raise Caml.Exit
    | 'h' ->
      Stdio.printf "\nhorizontal\n%!";
      begin
        let newzipoption = assert false in (* compute new zipper after insertion  *)
        (); (* update display *)
        loop newzipoption (count+1) (* loop *)
      end

    | 'v' ->
      Stdio.printf "\nvertical\n%!";
      begin
        assert false
      end

    | 'n' ->
      Stdio.printf "\nnext\n%!";
      begin
        assert false
      end
    | 'p' ->
      Stdio.printf "\nprevious\n%!";
      begin
        assert false
      end
    | '+' ->
      Stdio.printf "\nincrement size\n%!";
      begin
        assert false
      end
    | '-' ->
      Stdio.printf "\ndecrement size\n%!";
      begin
        assert false
      end

    | 'r' ->
      Stdio.printf "\nremove\n%!";
      begin
        assert false
      end
    | c ->
      printf "cannot process command '%c'\n%!" c;
      loop oz count

  in
  try
    loop None 0
  with
  | Stdlib.Exit -> ()


let () = main ()
