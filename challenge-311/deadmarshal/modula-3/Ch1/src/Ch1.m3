MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text,ASCII;

PROCEDURE UpperLower(READONLY Str:TEXT):TEXT =
  VAR Ret:TEXT := "";
  BEGIN
    FOR I := 0 TO Text.Length(Str)-1 DO
      WITH C = Text.GetChar(Str,I) DO
        IF C IN ASCII.Uppers THEN
          Ret := Ret & Text.FromChar(ASCII.Lower[C])
        ELSE
          Ret := Ret & Text.FromChar(ASCII.Upper[C])
        END
      END
    END;
    RETURN Ret
  END UpperLower;
  
BEGIN
  SIO.PutText(UpperLower("pERl")); SIO.Nl();
  SIO.PutText(UpperLower("rakU")); SIO.Nl();
  SIO.PutText(UpperLower("PyThOn")); SIO.Nl()
END Ch1.

