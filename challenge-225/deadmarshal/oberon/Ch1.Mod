MODULE Ch1;
  
  IMPORT Out;

  TYPE
    PArr = POINTER TO ARRAY OF ARRAY OF CHAR;

  VAR
    A1,A2:PArr;
    
  PROCEDURE Init;
  BEGIN
    NEW(A1,3,41);
    NEW(A2,3,43);
    COPY("Perl and Raku belong to the same family.",A1[0]);
    COPY("I love perl.",A1[1]);
    COPY("The Perl and Raku Conference.",A1[2]);
    COPY("The Weekly Challenge.",A2[0]);
    COPY("Python is the most popular guest language.",A2[1]);
    COPY("Team PWC has over 300 members.",A2[2]);
  END Init;

  PROCEDURE MaxWords(arr:PArr):LONGINT;
    VAR
      i,j,count,max:LONGINT;
  BEGIN
    count := 0; max := 0;
    FOR i := 0 TO LEN(arr^)-1 DO
      FOR j := 0 TO LEN(arr[i])-1 DO IF arr[i][j] = ' ' THEN INC(count) END
    END;
    IF count > max THEN max := count END;
    count := 0
    END;
    RETURN max+1
  END MaxWords;

BEGIN
  Init;
  Out.Int(MaxWords(A1),0); Out.Ln;
  Out.Int(MaxWords(A2),0); Out.Ln
END Ch1.

