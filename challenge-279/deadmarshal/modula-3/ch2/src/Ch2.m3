MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE SplitString(READONLY t:TEXT):BOOLEAN =
  VAR Count:CARDINAL := 0;
  BEGIN
    FOR I := 0 TO Text.Length(t)-1 DO
      IF Text.GetChar(t,I) IN SET OF CHAR{'a','e','i','o','u'} THEN
        INC(Count)
      END
    END;
    RETURN Count MOD 2 = 0
  END SplitString;

BEGIN
  SIO.PutBool(SplitString("perl")); SIO.Nl();
  SIO.PutBool(SplitString("book")); SIO.Nl();
  SIO.PutBool(SplitString("good morning")); SIO.Nl()
END Ch2.

