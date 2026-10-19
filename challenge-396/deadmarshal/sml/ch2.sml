structure Ch2 : sig
  val trionicList : int list -> bool
end =
struct
  fun trionicList xs =
      let
	fun sign x = if x < 0 then ~1 else if x > 0 then 1 else 0
	fun windowBy2(xs: 'a list):('a * 'a) list =
	    case xs of
	      a::(rest as b::_) => (a,b) :: windowBy2 rest
	    | _ => []
	fun dropWhile (x:''a,xs:''a list):''a list =
	    case xs of
	      y::t => if y = x then dropWhile(x,t) else xs
	    | [] => xs
	fun dedup(xs:''a list):''a list =
	    case xs of
	      [] => []
	    | h::t => h :: dedup(dropWhile(h,t))
	val signs = map (fn(a,b) => sign(b-a)) (windowBy2 xs)
      in
	dedup signs = [1,~1,1]
      end
end

val _ =
  let
    val l = List.map Ch2.trionicList [[1,3,5,4,2,6,8],
				      [1,4,4,2,1,3,5],
				      [2,10,3,1,9],
				      [1,2,3,4,3,2,1],
				      [1,3,6,4,2,7,8,4]]
    fun printList (xs:bool list):unit =
	print (String.concatWith " " (map Bool.toString xs) ^ "\n")
  in
    printList l
  end

