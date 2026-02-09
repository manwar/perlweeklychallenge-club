MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text,Fmt;

TYPE
  Pair = RECORD
    Pers,Root:INTEGER;
  END;
  
PROCEDURE DigitalRoot(READONLY N:INTEGER):Pair =
  VAR
    P:Pair := Pair{Pers := 0,Root := N};
    Sum:CARDINAL;
    Digit:INTEGER;
  BEGIN
    WHILE P.Root > 9 DO
      WITH StrNum = Fmt.Int(P.Root) DO
        Sum := 0;
        FOR I := 0 TO Text.Length(StrNum)-1 DO
          Digit := ORD(Text.GetChar(StrNum,I)) - ORD('0');
          INC(Sum,Digit)
        END;
        P.Root := Sum;
        INC(P.Pers)
      END
    END;
    RETURN P
  END DigitalRoot;

VAR
  Numbers := ARRAY[0..4] OF INTEGER{38,7,999,1999999999,101010};
  P:Pair;

BEGIN
  FOR I := FIRST(Numbers) TO LAST(Numbers) DO
    P := DigitalRoot(Numbers[I]);
    SIO.PutText(Fmt.F("Persistence  = %s\nDigital Root = %s\n",
                      Fmt.Int(P.Pers),
                      Fmt.Int(P.Root)));
  END;
END Ch1.

