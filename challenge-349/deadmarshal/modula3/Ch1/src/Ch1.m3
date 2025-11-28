MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE PowerString(READONLY S:TEXT):INTEGER =
  VAR Res,Temp := 1;
  BEGIN
    FOR I := 1 TO Text.Length(S)-1 DO
      IF Text.GetChar(S,I) = Text.GetChar(S,I-1) THEN
        INC(Temp);
        Res := MAX(Res,Temp)
      ELSE
        Temp := 1
      END
    END;
    RETURN Res
  END PowerString;
  
BEGIN
  SIO.PutInt(PowerString("textbook")); SIO.Nl();
  SIO.PutInt(PowerString("aaaaa")); SIO.Nl();
  SIO.PutInt(PowerString("hoorayyy")); SIO.Nl();
  SIO.PutInt(PowerString("x")); SIO.Nl();
  SIO.PutInt(PowerString("aabcccddeeffffghijjk")); SIO.Nl()
END Ch1.

