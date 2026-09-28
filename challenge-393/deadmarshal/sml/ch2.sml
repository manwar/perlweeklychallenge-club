structure Ch2 : sig
  val primeStep : string -> int
end =
struct
  fun primeStep s =
      let
	fun isPrime n =
	    if n <= 1 then false else not (hasDivisor n 2)
	  and hasDivisor n i =
	      if i * i > n then false
	      else
		if n mod i = 0 then true else hasDivisor n (i+1)
	fun step sum d =
	    if isPrime (sum - d) orelse isPrime (sum + d) then d
	    else step sum (d+1)
	val sum = ((fn l => List.foldl op+ 0 l) o
						List.map ord o
						String.explode) s
      in
	step sum 0
      end
end

val _ =
  let
    val l = List.map Ch2.primeStep
		     ["hello","football","a","challenge","perl"]
  in
    List.app (fn e => print(Int.toString e ^ " ")) l;
    print("\n")
  end

