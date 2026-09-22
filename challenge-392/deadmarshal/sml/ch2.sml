structure Ch2 : sig
  val wordsLengthProduct : string list -> int
end =
struct
  fun commonLetters (s1,s2) =
      let
	val cs2 = String.explode s2
      in
	List.exists (fn c => List.exists (fn d => c = d) cs2)
		    (String.explode s1)
      end

  fun wordsLengthProduct xs =
      let
	fun find ([],acc) = acc
	  | find (a::rest,acc) =
            let
	      val acc' = List.foldl
			   (fn (b,acc) =>
			      if commonLetters (a,b)
			      then acc
			      else Int.max
				     (acc,
				      String.size a * String.size b))
			   acc
			   rest
            in
              find (rest, acc')
            end
      in
	find (xs, 0)
      end
end

val _ =
  let
    val l = List.map Ch2.wordsLengthProduct
		     [["a", "ab", "abc", "d", "de", "def"],
		      ["a", "aa", "aaa", "aaaa"],
		      ["meet", "app", "code", "sky", "bold"],
		      ["a", "ab", "abc", "abcd", "efghi"],
		      ["xyz", "w", "abcdefg", "hij"]]
  in
    List.app (fn e => print(Int.toString e ^ " ")) l;
    print("\n")
  end

