MODULE Ch1;

  IMPORT Out,Strings,ethStrings;

  TYPE
    PArr = POINTER TO ARRAY OF ARRAY OF CHAR;

  VAR
    A1,A2:PArr;
    
  PROCEDURE Init;
  BEGIN
    NEW(A1,4,7); NEW(A2,2,4);
    COPY("Hello",A1[0]); COPY("Alaska",A1[1]); COPY("Dad",A1[2]);
    COPY("Peace",A1[3]);
    COPY("OMG",A2[0]); COPY("Bye",A2[1]);
  END Init;
  
  PROCEDURE AllMatch(Haystack,Needle:ARRAY OF CHAR):BOOLEAN;
    VAR
      i:LONGINT;
      s:ARRAY 2 OF CHAR;
  BEGIN
    s[1] := 0X;
    FOR i := 0 TO Strings.Length(Needle) DO
      s[0] := Needle[i];
      IF Strings.Pos(s,Haystack,0) = -1 THEN RETURN FALSE END
    END;
    RETURN TRUE
  END AllMatch;

  PROCEDURE KeyboardWord(VAR A:PArr);
    VAR
      i,j:LONGINT;
      qwerty:ARRAY 3,10 OF CHAR;
  BEGIN
    COPY("qwertyuiop",qwerty[0]);
    COPY("asdfghjkl",qwerty[1]);
    COPY("zxcvbnm",qwerty[2]);
    FOR i := 0 TO LEN(A^)-1 DO ethStrings.Lower(A[i],A[i]) END;
    FOR i := 0 TO LEN(qwerty)-1 DO
      FOR j := 0 TO LEN(A^)-1 DO
	IF AllMatch(qwerty[i],A[j]) THEN Out.String(A[j]); Out.Char(' ') END
      END
    END;
    Out.Ln
  END KeyboardWord;
    
BEGIN
  Init;
  KeyboardWord(A1);
  KeyboardWord(A2);
END Ch1.

