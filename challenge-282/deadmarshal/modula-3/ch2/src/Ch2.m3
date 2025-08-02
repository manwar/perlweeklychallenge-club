MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text,ASCII;

PROCEDURE ChangingKeys(READONLY Str:TEXT):CARDINAL =
  VAR C:CARDINAL := 0;
  BEGIN
    FOR I := 1 TO Text.Length(Str)-1 DO
      IF ASCII.Lower[Text.GetChar(Str,I)] #
        ASCII.Lower[Text.GetChar(Str,I-1)] THEN
        INC(C)
      END
    END;
    RETURN C
  END ChangingKeys;

BEGIN
  SIO.PutInt(ChangingKeys("pPeERrLl")); SIO.Nl();
  SIO.PutInt(ChangingKeys("rRr")); SIO.Nl();
  SIO.PutInt(ChangingKeys("GoO")); SIO.Nl()
END Ch2.

