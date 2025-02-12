MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text,CharArraySort;

PROCEDURE SortText(VAR Str:TEXT):TEXT =
  VAR
    A := NEW(REF ARRAY OF CHAR,Text.Length(Str));
  BEGIN
    Text.SetChars(A^,Str);
    CharArraySort.Sort(A^);
    RETURN Text.FromChars(A^)
  END SortText;
  
PROCEDURE FindAnagrams(VAR A:ARRAY OF TEXT):CARDINAL =
  VAR Sum:CARDINAL := 1;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO A[I] := SortText(A[I]) END;
    FOR I := 1 TO LAST(A) DO
      IF NOT Text.Equal(A[I-1],A[I]) THEN INC(Sum) END
    END;
    RETURN Sum
  END FindAnagrams;

VAR
  A1 := ARRAY[0..4] OF TEXT{"acca","dog","god","perl","repl"};
  A2 := ARRAY[0..4] OF TEXT{"abba","baba","aabb","ab","ab"};

BEGIN
  SIO.PutInt(FindAnagrams(A1)); SIO.Nl();
  SIO.PutInt(FindAnagrams(A2)); SIO.Nl()
END Ch2.

