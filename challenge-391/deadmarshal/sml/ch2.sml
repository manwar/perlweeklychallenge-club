structure Ch2 : sig
  type box
  val arrangeBox : box list -> int
  val mkBox : (int * int) -> box
end
= struct
  type box = {width:int,height:int}

  fun mkBox (w, h) : box = {width = w, height = h}

  fun compareBoxes ({width=wa,height=ha}:box,
                    {width=wb,height=hb}:box):bool =
      if wa <> wb then wa > wb else ha > hb

  fun addBox (processed:(box * int) list,b:box):(box * int) list =
      let
	val candidates =
	  List.mapPartial
	    (fn (prev,dp) =>
	       if #width prev < #width b andalso #height prev < #height b
	       then SOME (dp + 1)
	       else NONE)
	    processed
	val dpI = List.foldl Int.max 1 candidates
      in
	processed @ [(b,dpI)]
      end

  fun arrangeBox (boxes:box list):int =
      let
	val sorted = ListMergeSort.sort compareBoxes boxes
      in
	case sorted of
	  [] => 0
	| _ =>
	  let
	    val processed = List.foldl (fn (b,acc) => addBox(acc,b)) [] sorted
	  in
	    List.foldl (fn ((_,dp),m) => Int.max(dp,m)) 1 processed
	  end
      end  
end

val _ =
  let
    val l = List.map (fn l => Ch2.arrangeBox l)
		     [
		       [Ch2.mkBox(1,3),Ch2.mkBox(3,5),
			Ch2.mkBox(6,8),Ch2.mkBox(2,4)],
		       [Ch2.mkBox(4,5),Ch2.mkBox(4,6),
			Ch2.mkBox(6,7),Ch2.mkBox(2,3),Ch2.mkBox(4,3)],
		       [Ch2.mkBox(5,5),Ch2.mkBox(5,5),Ch2.mkBox(5,5)],
		       [Ch2.mkBox(2,100),Ch2.mkBox(3,200),
			Ch2.mkBox(4,300),Ch2.mkBox(5,50),
			Ch2.mkBox(5,400)],
		       [Ch2.mkBox(10,20),Ch2.mkBox(15,10),
			Ch2.mkBox(20,30),Ch2.mkBox(12,18),
			Ch2.mkBox(16,25)]]
  in
    List.app (fn e => print(Int.toString e ^ " ")) l;
    print("\n")
  end

