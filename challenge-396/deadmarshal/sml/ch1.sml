structure Ch1 : sig
  val finishingOrder : (int list * int list) -> int list
end =
struct
  structure IS = IntRedBlackSet

  fun finishingOrder (order: int list,friends:int list):int list =
      let
	val s = IS.addList (IS.empty,friends)
      in
	List.filter(fn e => IS.member(s,e)) order
      end
end

val _ =
  let
    val l =
      List.map (fn (a,b) => Ch1.finishingOrder(a,b))
	       [([3,1,4,2,5],[1,2,4]),
		([5,4,3,2,1],[1,3,5]),
		([2,4,1,3],[1,2,3,4]),
		([4,1,3,2],[3]),
		([1,3,2,6,5,4],[1,2,3])]
    fun printList (xs:int list):unit =
	print (String.concatWith " " (map Int.toString xs) ^ "\n")
  in
    List.map printList l
  end

