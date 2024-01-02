MODULE Ch2 EXPORTS Main;

IMPORT IO,Text,Scan;

VAR
  A1 := ARRAY[0..4] OF TEXT{"perl","2","000","python","r4ku"};
  A2 := ARRAY[0..3] OF TEXT{"001","1","000","0001"};

PROCEDURE IsNumeric(VAR t:TEXT):BOOLEAN =
  BEGIN
    FOR I := 0 TO Text.Length(t)-1 DO
      IF NOT Text.GetChar(t,I) IN SET OF CHAR{'0'..'9'} THEN RETURN FALSE END
    END;
    RETURN TRUE
  END IsNumeric;

PROCEDURE AlphanumericStringValue(VAR A:ARRAY OF TEXT):CARDINAL =
  VAR Max,N:CARDINAL := 0;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF IsNumeric(A[I]) THEN N := Scan.Unsigned(A[I],10)
      ELSE N := Text.Length(A[I])
      END;
      IF N > Max THEN Max := N END
    END;
    RETURN Max
  END AlphanumericStringValue;

BEGIN
  IO.PutInt(AlphanumericStringValue(A1)); IO.Put("\n");
  IO.PutInt(AlphanumericStringValue(A2)); IO.Put("\n");
END Ch2.

