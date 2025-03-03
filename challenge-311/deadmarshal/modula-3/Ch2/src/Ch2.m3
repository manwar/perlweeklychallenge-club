MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text,Fmt;

PROCEDURE GroupDigitSum(READONLY Str:TEXT;
                        READONLY N:CARDINAL):TEXT =
  VAR
    X:INTEGER;
    Sb:TEXT := "";
    Ret:TEXT := Str;
  BEGIN
    WHILE Text.Length(Ret) > N DO
      Sb := "";
      FOR I := 0 TO Text.Length(Ret)-1 BY N DO
        X := 0;
        FOR J := I TO MIN(I+N,Text.Length(Ret))-1 DO
          INC(X,ORD(Text.GetChar(Ret,J)) - ORD('0'))
        END;
        Sb := Sb & Fmt.Int(X);
      END;
      Ret := Sb
    END;
    RETURN Ret
  END GroupDigitSum;

BEGIN
  SIO.PutText(GroupDigitSum("111122333",3)); SIO.Nl();
  SIO.PutText(GroupDigitSum("1222312",2)); SIO.Nl();
  SIO.PutText(GroupDigitSum("100012121001",4)); SIO.Nl()
END Ch2.

