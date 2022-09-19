MODULE Ch1 EXPORTS Main;

IMPORT IO, Scan, Lex, FloatMode, StableError, Params;
FROM Fmt IMPORT Bool;

VAR
  Input:INTEGER;
  
PROCEDURE IsEsthetic(N:INTEGER):BOOLEAN =
PROCEDURE Uabs(READONLY A,B:INTEGER):INTEGER =
BEGIN
  IF A < B THEN RETURN B - A END;
  RETURN A - B;
END Uabs;
VAR
  I,J:INTEGER;
BEGIN
  IF N = 0 THEN RETURN FALSE END;
  I := N MOD 10;
  N := N DIV 10;
  WHILE N > 0 DO
    J := N MOD 10;
    IF Uabs(I,J) # 1 THEN RETURN FALSE END;
    N := N DIV 10;
    I := J;
  END;
  RETURN TRUE;
END IsEsthetic;

BEGIN
  IF Params.Count # 2 THEN StableError.Halt("No arg(s) provided!") END;
  TRY
    Input := Scan.Int(Params.Get(1));
  EXCEPT
  | Lex.Error, FloatMode.Trap =>
    IO.Put("Malformed arg(s) provided!");
  END;
  
  IO.Put(Bool(IsEsthetic(Input)));
END Ch1.
