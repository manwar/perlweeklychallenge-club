MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text,TextExtras,CharArraySort;

PROCEDURE SortText(READONLY T:TEXT):TEXT =
  VAR A:REF ARRAY OF CHAR :=
      NEW(REF ARRAY OF CHAR,Text.Length(T));
  BEGIN
    Text.SetChars(A^,T);
    CharArraySort.Sort(A^);
    RETURN Text.FromChars(A^)
  END SortText;
  
PROCEDURE ReverseString(READONLY T:TEXT;
                        READONLY C:CHAR):TEXT =
  VAR
    I:CARDINAL := 0;
  BEGIN
    IF TextExtras.FindChar(T,C,I) THEN
      RETURN SortText(Text.Sub(T,0,I+1)) & Text.Sub(T,I+1)
    ELSE RETURN T
    END;
  END ReverseString;
  
BEGIN
  SIO.PutText(ReverseString("challenge",'e')); SIO.Nl();
  SIO.PutText(ReverseString("programming",'a')); SIO.Nl();
  SIO.PutText(ReverseString("champion",'b')); SIO.Nl()
END Ch2.

