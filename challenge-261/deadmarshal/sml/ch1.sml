fun element_digit_sum list =
    let fun flatten list =
	    let fun aux acc list =
		    case list of
			[] => acc
		      | []::t => aux acc t
		      | (x::y)::t => aux (x::acc) (y::t)
	    in
	      List.rev (aux [] list)
	    end
	fun number_to_list n =
	    List.map(fn s => valOf(Int.fromString s))
		    (List.map(fn d => str d)
			     ((String.explode o Int.toString) n))
	val nums = List.map number_to_list list
	val flats = flatten nums
    in
      abs((List.foldr op+ 0 flats) - (List.foldr op+ 0 list))
    end

val _ =
    print(Int.toString(element_digit_sum [1,2,3,45]) ^ "\n");
    print(Int.toString(element_digit_sum [1,12,3]) ^ "\n");
    print(Int.toString(element_digit_sum [1,2,3,4]) ^ "\n");
    print(Int.toString(element_digit_sum [236,416,336,350]) ^ "\n");
      
