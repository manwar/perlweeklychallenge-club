MODULE Ch2 EXPORTS Main;

IMPORT IO,Text;

VAR
  A1:ARRAY[0..3] OF TEXT := ARRAY OF TEXT{"pay","attention",
                                          "practice","attend"};
  A2:ARRAY[0..3] OF TEXT := ARRAY OF TEXT{"janet","julia",
                                          "java","javascript"};
  Pat1:TEXT := "at";
  Pat2:TEXT := "ja";

PROCEDURE CountWords(READONLY A:ARRAY OF TEXT;READONLY Pat:TEXT):INTEGER =
  VAR
    Count:INTEGER := 0;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF Text.Equal(Text.Sub(A[I],0,Text.Length(Pat)),Pat) THEN INC(Count) END;
    END;
    RETURN Count
  END CountWords;
  
BEGIN
  IO.PutInt(CountWords(A1,Pat1)); IO.Put("\n");
  IO.PutInt(CountWords(A2,Pat2)); IO.Put("\n");
END Ch2.

