MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text,Fmt;

PROCEDURE GoodInteger(N:INTEGER):TEXT =
  VAR
    Str:TEXT := Fmt.Int(N);
    Prev:CHAR := '\000';
    Seen:CARDINAL := 0;
  BEGIN
    FOR I := 0 TO Text.Length(Str)-1 DO
      IF Prev = Text.GetChar(Str,I) THEN INC(Seen)
      ELSIF Seen = 3 THEN
        WITH C = Text.FromChar(Prev) DO
          RETURN C & C & C
        END;
      ELSE
        Prev := Text.GetChar(Str,I);
        Seen := 1
      END;
    END;
    RETURN "-1";
  END GoodInteger;
  
BEGIN
  SIO.PutText(GoodInteger(12344456) & "\n");
  SIO.PutText(GoodInteger(1233334) & "\n");
  SIO.PutText(GoodInteger(10020003) & "\n")
END Ch1.

