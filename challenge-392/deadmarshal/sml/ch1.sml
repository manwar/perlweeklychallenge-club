structure Ch1 : sig
  val convertPalindrome : string -> string
end =
struct
  fun convertPalindrome s =
      let
	val r = String.implode(List.rev(String.explode s))
	val n = String.size s
	fun find i =
	    if String.substring(s,0,n-i) = String.extract(r,i,NONE)
	    then String.substring(r,0,i) ^ s
	    else find(i+1)
      in
	find 0
      end
end

val _ =
  let
    val l = List.map Ch1.convertPalindrome
		     ["pinnipeds","abcd","bananas",
		      "dissident","cailliachs"]
  in
    List.app (fn e => print(e ^ " ")) l;
    print("\n")
  end

