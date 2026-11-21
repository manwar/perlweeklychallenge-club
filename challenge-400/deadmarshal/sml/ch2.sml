structure Ch2 : sig
  val minimumGeneticMutation : string * string * string list -> int
end = struct
  structure StringKey = struct
    type ord_key = string
    val compare = String.compare
  end
  structure S = RedBlackSetFn(StringKey)

  fun minimumGeneticMutation (start:string,target:string,bank:string list):int =
      let
        fun mutations gene =
            let
              val chars = String.explode gene
              val n = length chars
            in
              List.concat
                (List.tabulate (n, fn i =>
				     let
				       val old = List.nth(chars,i)
				       val prefix = List.take(chars,i)
				       val suffix = List.drop(chars,i+1)
				     in
				       List.mapPartial
					 (fn c =>
					    if c = old then NONE
					    else SOME (String.implode (prefix @ (c::suffix))))
					 [#"A", #"C", #"G", #"T"]
				     end))
            end
	
        fun bfs(frontier:string list,unvisited:S.set,target:string,steps:int):int =
            case frontier of
              [] => ~1
            | _ =>
              let
                val nextSet =
                  List.foldl
                    (fn (g, acc) => if S.member (unvisited, g) then S.add (acc, g) else acc)
                    S.empty
                    (List.concat (List.map mutations frontier))
              in
                if S.member (nextSet, target) then steps + 1
                else bfs (S.listItems nextSet,
                          S.difference (unvisited, nextSet),
                          target,
                          steps + 1)
              end
      in
        if start = target then 0
        else
          let
            val valid = S.fromList bank
          in
            if not (S.member (valid, target)) then ~1
            else bfs ([start],
                      (S.delete (valid, start) handle LibBase.NotFound => valid),
                      target,
                      0)
          end
      end
end

val _ =
  let
    val tests =
      [ ("AACCGGTT", "AACCGGTA", ["AACCGCTA", "AAACGGTA"]),
        ("AACCGGTT", "AACCGGAA",
         ["AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"]),
        ("AAAAAAAA", "AAAAACCC", ["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"]),
        ("GAAAAAAA", "GCCCCCCC",
         ["GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA",
          "GCCCCCAA", "GCCCCCCA", "GCCCCCCC"]),
        ("AACCGGTT", "AACCGGTT", ["AACCGGTA"]) ]

    val l = List.map Ch2.minimumGeneticMutation tests
    fun printIntList xs =
	print ("[" ^ String.concatWith ", "
		   (List.map Int.toString xs) ^ "]\n")
  in
    printIntList l
  end

