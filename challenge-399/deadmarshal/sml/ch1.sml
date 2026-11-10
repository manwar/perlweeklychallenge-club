structure Ch1 : sig
  val longestRepeatingCharacter : string -> int -> int
end =
struct
  structure CharMap = RedBlackMapFn(struct
    type ord_key = char
    val compare = Char.compare
  end)

  fun longestRepeatingCharacter s k =
      let
        val chars = String.explode s

        fun count (counts, c) =
            case CharMap.find (counts, c) of
              SOME n => n
            | NONE => 0

        fun helper [] _ left right _ _ = right - left
          | helper (c :: rest) leftChars left right maxCount counts =
            let
              val cnt = count (counts, c) + 1
              val counts = CharMap.insert (counts, c, cnt)
              val maxCount = Int.max (maxCount, cnt)
            in
              if right - left + 1 - maxCount > k then
                (case leftChars of
                   lc :: leftRest =>
                   let
                     val counts =
                       CharMap.insert (counts, lc, count (counts, lc) - 1)
                   in
                     helper rest leftRest (left + 1) (right + 1) maxCount counts
                   end
                 | [] => helper rest [] left (right + 1) maxCount counts)
              else
                helper rest leftChars left (right + 1) maxCount counts
            end
      in
        helper chars chars 0 0 0 CharMap.empty
      end
end

val _ =
  let val l = List.map (fn(s,k) => Ch1.longestRepeatingCharacter s k)
		       [("AAAAA",2),
			("ABCDE",4),
			("AAABBBBAA",1),
			("ABACADA",2),
			("BAAABAAAA",1)]
    fun printIntList xs =
	print ("[" ^ String.concatWith ", "
		   (List.map Int.toString xs) ^ "]\n")
  in
    printIntList l
  end

