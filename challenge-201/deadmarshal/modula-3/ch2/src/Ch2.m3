MODULE Ch2 EXPORTS Main;

IMPORT IO;

VAR
  Count:INTEGER := 0;
  Arr:ARRAY[0..4] OF INTEGER;
  
  PROCEDURE FindCombinations(VAR Arr:ARRAY OF INTEGER;
				 Index,Num,Reducednum:INTEGER) = 
    VAR
      Prev:INTEGER;
  BEGIN
    IF Reducednum < 0 THEN RETURN END;
    IF Reducednum = 0 THEN
      INC(Count);
      RETURN;
    END;
    IF Index = 0 THEN Prev := 1 ELSE Prev := Arr[Index-1] END;
    FOR I := Prev TO Num DO
      Arr[Index] := I;
      FindCombinations(Arr,Index+1,Num,Reducednum-I);
    END;
  END FindCombinations;

BEGIN
  FindCombinations(Arr,0,5,5);
  IO.PutInt(Count); IO.Put("\n");
END Ch2.

