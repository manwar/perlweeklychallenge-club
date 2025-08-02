MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE PercentageOfCharacter(READONLY Str:TEXT;
                                READONLY C:CHAR):CARDINAL =
  VAR Count:CARDINAL := 0;
  BEGIN
    FOR I := 0 TO Text.Length(Str)-1 DO
      IF Text.GetChar(Str,I) = C THEN INC(Count) END
    END;
    RETURN FLOOR((FLOAT(Count) / FLOAT(Text.Length(Str))) * 100.0 + 0.5)
  END PercentageOfCharacter;
  
BEGIN
  SIO.PutInt(PercentageOfCharacter("perl",'e')); SIO.Nl();
  SIO.PutInt(PercentageOfCharacter("java",'a')); SIO.Nl();
  SIO.PutInt(PercentageOfCharacter("python",'m')); SIO.Nl();
  SIO.PutInt(PercentageOfCharacter("ada",'a')); SIO.Nl();
  SIO.PutInt(PercentageOfCharacter("ballerina",'l')); SIO.Nl();
  SIO.PutInt(PercentageOfCharacter("analitik",'k')); SIO.Nl(); 
END Ch1.

