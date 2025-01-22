MODULE Ch1 EXPORTS Main;

IMPORT SIO,Math,Fmt,Scan,BoolSeq;
IMPORT FloatMode,Lex,StableError;

VAR
  A1 := ARRAY[0..2] OF INTEGER{1,0,1};
  A2 := ARRAY[0..2] OF INTEGER{1,1,0};
  A3 := ARRAY[0..19] OF INTEGER{1,1,1,1,0,1,0,0,0,0,1,0,1,0,0,1,0,0,0,1};

PROCEDURE IsPrime(READONLY N:INTEGER):BOOLEAN =
  BEGIN
    IF N <= 1 THEN RETURN FALSE END;
    IF N = 2 OR N = 3 THEN RETURN TRUE END;
    IF N MOD 2 = 0 OR N MOD 3 = 0 THEN RETURN FALSE END;
    FOR I := 5 TO FLOOR(Math.sqrt(FLOAT(N,LONGREAL))) BY 6 DO
      IF N MOD I = 0 OR N MOD (I+2) = 0 THEN RETURN FALSE END
    END;
    RETURN TRUE
  END IsPrime;
  
PROCEDURE BinaryPrefix(VAR A:ARRAY OF INTEGER):BoolSeq.T
  RAISES{FloatMode.Trap,Lex.Error} =
  VAR
    Bin:TEXT := "";
    Ret := NEW(BoolSeq.T).init();
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      Bin := Bin & Fmt.Int(A[I]);
      Ret.addhi(IsPrime(Scan.Int(Bin,2)))
    END;
    RETURN Ret
  END BinaryPrefix;

PROCEDURE PrintSeq(READONLY S:BoolSeq.T) =
  BEGIN
    FOR I := 0 TO S.size()-1 DO
      SIO.PutBool(S.get(I));
      SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintSeq;
  
BEGIN
  TRY
    PrintSeq(BinaryPrefix(A1));
    PrintSeq(BinaryPrefix(A2));
    PrintSeq(BinaryPrefix(A3))
  EXCEPT
    FloatMode.Trap => StableError.Halt("FloatMode.Trap exception occurred!")
  | Lex.Error => StableError.Halt("Lex.Error exception occurred!")
  ELSE
    StableError.Halt("Some other exception occurred!")
  END;
END Ch1.

