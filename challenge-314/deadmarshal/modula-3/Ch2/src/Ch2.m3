MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE SortColumn(READONLY A:ARRAY OF TEXT):CARDINAL =
  VAR Ret:CARDINAL;
  BEGIN
    FOR J := 0 TO Text.Length(A[FIRST(A)])-1 DO
      FOR I := FIRST(A)+1 TO LAST(A) DO
        IF Text.GetChar(A[I],J) < Text.GetChar(A[I-1],J) THEN
          INC(Ret);
          EXIT
        END
      END;
    END;
    RETURN Ret
  END SortColumn;
  
BEGIN
  SIO.PutInt(SortColumn(ARRAY OF TEXT{"swpc", "tyad", "azbe"})); SIO.Nl();
  SIO.PutInt(SortColumn(ARRAY OF TEXT{"cba", "daf", "ghi"})); SIO.Nl();
  SIO.PutInt(SortColumn(ARRAY OF TEXT{"a","b","c"})); SIO.Nl()
END Ch2.

