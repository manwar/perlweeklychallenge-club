MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text,Word;

PROCEDURE MaxScore(READONLY Str:TEXT):CARDINAL =
  VAR L,R,Res:CARDINAL;
  BEGIN
    FOR I := 0 TO Text.Length(Str)-1 DO
      IF Text.GetChar(Str,I) = '1' THEN INC(R) END
    END;
    FOR I := 0 TO Text.Length(Str)-2 DO
      WITH C = ORD(Text.GetChar(Str,I)) - ORD('0') DO
        INC(L,Word.Xor(C,1));
        DEC(R,C);
        Res := MAX(Res,L+R)
      END
    END;
    RETURN Res
  END MaxScore;
  
BEGIN
  SIO.PutInt(MaxScore("0011")); SIO.Nl();
  SIO.PutInt(MaxScore("0000")); SIO.Nl();
  SIO.PutInt(MaxScore("1111")); SIO.Nl();
  SIO.PutInt(MaxScore("0101")); SIO.Nl();
  SIO.PutInt(MaxScore("011101")); SIO.Nl()
END Ch2.

