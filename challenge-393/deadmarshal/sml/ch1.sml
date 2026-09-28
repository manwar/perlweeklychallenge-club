structure Ch1 : sig
  val pythagorasMultiplied : int -> int
end =
struct
  fun pythagorasMultiplied n =
      let
	fun outer m n count =
	    if m * m + 1 <= n then outer (m+1) n (inner m 1 n count)
	    else count
	  and inner m k n count =
	      if k >= m then count
	      else 
		let val c = m * m + k * k
		  val add = if (m - k) mod 2 = 1 andalso
		  c <= n andalso
		  gcd m k = 1 then 2 * (n div c) else 0
		in
		  inner m (k+1) n (count + add)
		end
	  and gcd a 0 = a
	    | gcd a b = gcd b (a mod b)
      in
	outer 2 n 0
      end
end

val _ =
  let
    val l = List.map Ch1.pythagorasMultiplied [20,7,1,15,30]
  in
    List.app (fn e => print(Int.toString(e) ^ " ")) l;
    print("\n")
  end

