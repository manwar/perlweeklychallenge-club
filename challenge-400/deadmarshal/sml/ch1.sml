structure Ch1 : sig
  val largestInterval : int -> int
end = struct

  fun largestInterval n =
  let
    fun hasUniqueDigits n =
	let fun noDups [] = true
	  | noDups (c::cs) =
	    not (List.exists (fn d => d = c) cs) andalso noDups cs
	in
	  noDups (String.explode (Int.toString n))
	end
  in
    if n < 1 then 0
    else
    let
      val uniques = List.filter
		      hasUniqueDigits
		      (List.tabulate(n,fn i => i+1))
    in
      case uniques of
	[] => 0
      | first::rest =>
	#2 (List.foldl
	      (fn (x,(prev,best)) => (x,Int.max(best,x-prev)))
	      (first,0)
	      rest)
    end
  end
end

val _ =
  let
    val l = List.map Ch1.largestInterval [20,110,500,2026,10000]
    fun printIntList xs =
	print ("[" ^ String.concatWith ", "
		   (List.map Int.toString xs) ^ "]\n")
  in
    printIntList l
  end

