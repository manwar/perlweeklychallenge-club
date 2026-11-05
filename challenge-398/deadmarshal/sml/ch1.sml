structure Ch1 : sig
  val divisibleAverage : int list -> int
end =
struct
  fun divisibleAverage xs =
      let
	val f = List.filter (fn e => e mod 2 = 0 andalso e mod 3 = 0)
			    xs
	val n = List.length f
      in
	case n of
	  0 => 0
	| _ => (List.foldl op+ 0 f) div n
      end
end

val _ =
  let val l = List.map Ch1.divisibleAverage [[18,5,7,11],
					     [6,12,18,24,30,40],
					     [3,9,15,21,27],
					     [6,12,14,20],
					     [6,6,6,12,12]]
    fun printIntList xs =
	print("[" ^ String.concatWith "," (map Int.toString xs) ^ "]")    
  in
    printIntList l
  end

