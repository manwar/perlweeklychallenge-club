MODULE Ch2 EXPORTS Main;

IMPORT IO;
FROM BigInteger IMPORT T,Add,Mul,FromInteger;
FROM BigIntegerFmtLex IMPORT Fmt;

PROCEDURE SylvestersSequence() = 
VAR
  K:INTEGER := 2;
  Arr:ARRAY[0..9] OF T;
BEGIN
  Arr[0] := FromInteger(2);
  Arr[1] := FromInteger(3);
  FOR I := 2 TO LAST(Arr) DO Arr[I] := FromInteger(1) END;
  FOR I := 2 TO LAST(Arr) DO
    FOR J := 0 TO K-1 DO 
      Arr[K] := Mul(Arr[K], Arr[J]);
    END;
    Arr[K] := Add(Arr[K], FromInteger(1));
    INC(K);
  END;
  FOR I := FIRST(Arr) TO LAST(Arr) DO
    IO.Put(Fmt(Arr[I]) & "\n");
  END;
END SylvestersSequence;

BEGIN
  SylvestersSequence();
END Ch2.
