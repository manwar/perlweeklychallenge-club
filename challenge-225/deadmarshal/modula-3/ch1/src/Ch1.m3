MODULE Ch1 EXPORTS Main;

IMPORT IO,Text;

VAR
  A1:ARRAY[0..2] OF TEXT := ARRAY OF TEXT{"Perl and Raku belong to the same family.",
                                          "I love Perl",
                                          "The Perl and Raku Conference."};
  A2:ARRAY[0..2] OF TEXT := ARRAY OF TEXT{"The Weekly Challenge.",
                                          "Python is the most popular guest language.",
                                          "Team PWC has over 300 members."};
  
PROCEDURE MaxWords(VAR A:ARRAY OF TEXT):INTEGER =
  VAR Count,Max:INTEGER := 0;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      FOR J := 0 TO Text.Length(A[I])-1 DO
        IF Text.GetChar(A[I],J) = ' ' THEN INC(Count) END;
      END;
      IF Count > Max THEN Max := Count END;
      Count := 0;
    END;
    RETURN Max+1
  END MaxWords;

BEGIN
  IO.PutInt(MaxWords(A1)); IO.Put("\n");
  IO.PutInt(MaxWords(A2)); IO.Put("\n");
END Ch1.

