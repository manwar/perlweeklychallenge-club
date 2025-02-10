fun decodeXor xs first =
    let fun aux _ [] acc = List.rev acc
	  | aux first (x::xs) acc =
	    let val t = Word.xorb (Word.fromInt (List.hd acc),
				   Word.fromInt x)
	    in 
	      aux first xs (Word.toInt(t) :: acc)
	    end
    in
      aux first xs [first]
    end;

decodeXor [1,2,3] 1;
decodeXor [6,2,7,3] 4;

