structure Ch2 : sig
  val stringDifference : string list -> (string,string) Result.t
end = struct
  structure KeyMap = RedBlackMapFn(struct
    type ord_key = int list
    val compare = List.collate Int.compare
  end)

  fun diffs (s:string):int list =
      let
	fun helper (a::(rest as b::_)) = (b - a)::helper rest
	  | helper _ = []
      in
	helper (map ord (explode s))
      end

  fun stringDifference(words:string list):(string,string) Result.t =
      let
	val keyed = map (fn w => (diffs w,w)) words
	val counts =
	  foldl
	    (fn ((k,_),m) =>
               KeyMap.insert(m,k,1 + getOpt(KeyMap.find(m,k),0)))
	    KeyMap.empty
	    keyed
	fun findUnique [] = Result.Error ""
	  | findUnique ((k,w)::rest) =
	    case KeyMap.find (counts,k) of
	      SOME 1 => Result.Ok w
	    | _ => findUnique rest
      in
	findUnique keyed
      end
end

val _ =
  let
    val l = List.map Ch2.stringDifference
		     [["ab","bc","cd","zy"],
		      ["cba","fed","azy"],
		      ["pop","ada","beb","cfc"],
		      ["aaaa","zzzz","mmmm","aaba"],
		      ["aceg","bdfh","cegi","azbz"]]
    fun resultToString (Result.Error e) = ""
      | resultToString (Result.Ok s) = s
    fun printList xs =
	print("[" ^ String.concatWith "," (map resultToString xs) ^ "]")
  in
    printList l
  end

