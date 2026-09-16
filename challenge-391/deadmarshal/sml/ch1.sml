fun arrayMedian l1 l2 =
    let
      val resorted = ListMergeSort.sort op> (l1 @ l2)
      val len = List.length resorted
    in
      case len of
        0 => 0.0
      | _ =>
        case len mod 2 of
          1 => Real.fromInt (List.nth(resorted, len div 2))
        | _ =>
          let
            val leftMiddle = len div 2 - 1
            val left  = List.nth(resorted, leftMiddle)
            val right = List.nth(resorted, leftMiddle + 1)
          in
            (Real.fromInt left + Real.fromInt right) / 2.0
          end
    end

val _ =
  let
    val l = List.map (fn (left,right) => arrayMedian left right)
                     [([2],[4]),
                      ([1,2,3],[7,8,9,10]),
                      ([],[10,20,30,40]),
                      ([100],[1,2,3,4,5,6,7]),
                      ([1,2,2],[2,2,3])]
  in
    List.app (fn e => print(Real.toString e ^ " ")) l;
    print("\n")
  end

