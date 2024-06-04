MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE StringScore(READONLY t:TEXT):INTEGER =
  VAR Sum:INTEGER := 0;
  BEGIN
    FOR I := 0 TO Text.Length(t)-2 DO
      INC(Sum,ABS(ORD(Text.GetChar(t,I+1)) - ORD(Text.GetChar(t,I))))
    END;
    RETURN Sum
  END StringScore;

BEGIN
  SIO.PutInt(StringScore("hello")); SIO.Nl();
  SIO.PutInt(StringScore("perl")); SIO.Nl();
  SIO.PutInt(StringScore("raku")); SIO.Nl()
END Ch2.

