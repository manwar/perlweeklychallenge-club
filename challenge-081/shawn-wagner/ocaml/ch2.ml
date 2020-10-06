let find_def tbl key def =
  match Hashtbl.find_opt tbl key with
  | Some x -> x
  | None -> def

let re = Str.regexp "[.\"(),]\\|--\\|'s"

let strip_special word = Str.global_replace re "" word
  
let task2 filename =
  let ib = Scanf.Scanning.open_in filename in
  let words = Hashtbl.create 100 in
  let add_word word =
    if word <> "" then begin
      let word = strip_special word in
      Hashtbl.replace words word ((find_def words word 0) + 1);
      true
    end else
      false in
  while  Scanf.bscanf ib  " %s" add_word do
    ()
  done;
  Scanf.Scanning.close_in ib;
  let maxfreq = ref 0 in
  let frequencies = Hashtbl.create (Hashtbl.length words) in
  Hashtbl.iter (fun w count -> Hashtbl.add frequencies count w;
                 maxfreq := max count !maxfreq) words;
  for count = 1 to !maxfreq do
    if Hashtbl.mem frequencies count then begin
      Printf.printf "%d " count;
      List.iter (function word -> Printf.printf "%s " word)
        (List.sort String.compare (Hashtbl.find_all frequencies count));
      print_newline()
    end
  done
    
let _ =
  task2 "input"

