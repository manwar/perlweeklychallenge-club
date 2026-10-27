structure Ch1 : sig
  val absentSmallestPositive : int list -> int
end =
struct
  structure S = IntBinarySet
  fun absentSmallestPositive xs = 
      let
	val s = S.addList (S.empty,xs)
	val n = List.length xs
	val sum = List.foldl op+ 0 xs
	val start = Int.max(1,Int.quot(sum,n)+1)
	fun helper (0,acc) = acc
	  | helper (k,acc) =
	    helper (k - 1, if S.member (s,acc) then acc + 1 else acc)
      in
	helper(n+1,start)
      end  
end

val _ =
  let
    val l = List.map Ch1.absentSmallestPositive
		     [[1,2,4,5,6],[~5,~2,~1,3],
		      [1,2,3],[2,3,7,8],[1,1,1,10]]
  in
    List.app (fn e => print(Int.toString(e) ^ " ")) l;
    print("\n")
  end

