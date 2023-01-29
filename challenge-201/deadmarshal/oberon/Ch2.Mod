MODULE Ch2;

  IMPORT Out;

  VAR
    count:INTEGER;
    arr:ARRAY 5 OF INTEGER;
    
  PROCEDURE FindCombinations(VAR arr:ARRAY OF INTEGER;
				 index,num,reducednum:INTEGER);
    VAR
      i:LONGINT;
      prev:INTEGER;
  BEGIN
    IF reducednum < 0 THEN RETURN END;
    IF reducednum = 0 THEN
      INC(count);
      RETURN;
    END;
    IF index = 0 THEN prev := 1 ELSE prev := arr[index-1] END;
    FOR i := prev TO num DO
      arr[index] := SHORT(i);
      FindCombinations(arr,index+1,num,reducednum-SHORT(i));
    END;
  END FindCombinations;

BEGIN
  count := 0;
  FindCombinations(arr,0,5,5);
  Out.Int(count,0); Out.Ln;
END Ch2.

