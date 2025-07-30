MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text,TextConv,Fmt,Scan,Lex,FloatMode;
FROM StableError IMPORT Halt;

PROCEDURE BinaryDate(READONLY S:TEXT):TEXT
  RAISES{Lex.Error,FloatMode.Trap} =
  VAR A := ARRAY[0..2] OF TEXT{"",..};
  BEGIN
    A[0] := Text.Sub(S,0,4);
    A[1] := Text.Sub(S,5,2);
    A[2] := Text.Sub(S,8,2);
    FOR I := FIRST(A) TO LAST(A) DO
      A[I] := Fmt.Int(Scan.Int(A[I]),2)
    END;
    RETURN TextConv.Implode(A,'-')
  END BinaryDate;

BEGIN
  TRY
    SIO.PutText(BinaryDate("2025-07-26")); SIO.Nl();
    SIO.PutText(BinaryDate("2000-02-02")); SIO.Nl();
    SIO.PutText(BinaryDate("2024-12-31")); SIO.Nl()
  EXCEPT
    Lex.Error => Halt("Lex.Error")
  | FloatMode.Trap => Halt("FloatMode.Trap")
  ELSE
    Halt("Some other exception!")
  END;
END Ch1.

