structure Ch2 : sig
  val binaryReflection : int list -> int list
end =
struct
  fun binaryReflection xs =
      let
	fun reflect e =
	    if e < 0 then raise Domain
	    else
	      let val s = String.implode(
		List.rev(String.explode(Int.fmt StringCvt.BIN e)))
	      in
		valOf (StringCvt.scanString (Int.scan StringCvt.BIN) s)
	      end
	val pairs = List.map (fn e => (reflect e,e)) xs
	fun gt ((ra,a),(rb,b)) =
	    ra > rb orelse (ra = rb andalso a > b)
	val sorted = ListMergeSort.sort gt pairs
      in
	List.map (fn (_,e) => e) sorted
      end
end

val _ =
  let
    val l = List.map Ch2.binaryReflection
		     [[3,6,12],[1,2,4,8],[7,8,9,10],
		      [5,9,15,17],[11,13,14,19]]
    fun printIntList xs =
	List.app (fn e => print(Int.toString(e) ^ " ")) xs
  in
    List.map (fn e => (printIntList e; print("\n"))) l
  end

