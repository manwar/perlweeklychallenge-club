MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text,TextConv;

PROCEDURE CountAsterisks(READONLY t:TEXT):CARDINAL =
  VAR
    Len:CARDINAL := TextConv.ExplodedSize(t,SET OF CHAR{'|'});
    A:REF ARRAY OF TEXT := NEW(REF ARRAY OF TEXT,Len);
    Count:CARDINAL := 0;
  BEGIN
    TextConv.Explode(t,A^,SET OF CHAR{'|'});
    FOR I := FIRST(A^) TO LAST(A^) DO
      IF I MOD 2 = 0 THEN
        FOR J := 0 TO Text.Length(A[I])-1 DO
          IF Text.GetChar(A[I],J) = '*' THEN INC(Count) END
        END
      END
    END;
    RETURN Count
  END CountAsterisks;
  
BEGIN
  SIO.PutInt(CountAsterisks("p|*e*rl|w**e|*ekly|")); SIO.Nl();
  SIO.PutInt(CountAsterisks("perl")); SIO.Nl();
  SIO.PutInt(CountAsterisks("th|ewe|e**|k|l***ych|alleng|e")); SIO.Nl();
END Ch2.

