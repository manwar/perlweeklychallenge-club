MODULE Ch1 EXPORTS Main;

IMPORT IO,Fmt,Text;
  
VAR
  A1:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{1,34,5,6};
  A2:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{1,24,51,60};

PROCEDURE SeparateDigits(VAR A:ARRAY OF INTEGER) =
  VAR
    Temp:TEXT := "";
BEGIN
  FOR I := FIRST(A) TO LAST(A) DO
    IF A[I] > 9 THEN
      Temp := Fmt.Int(A[I]);
      FOR J := 0 TO Text.Length(Temp)-1 DO
        IO.PutChar(Text.GetChar(Temp,J));
        IO.Put(" ");
      END;
    ELSE
      IO.PutInt(A[I]);
      IO.Put(" ");
    END;
  END;
  IO.Put("\n")
END SeparateDigits;

BEGIN
  SeparateDigits(A1);
  SeparateDigits(A2);
END Ch1.

