MODULE Ch1 EXPORTS Main;

IMPORT IO,Text,ASCII;

VAR
  A1:ARRAY[0..3] OF TEXT := ARRAY OF TEXT{"Hello","Alaska","Dad","Peace"};
  A2:ARRAY[0..1] OF TEXT := ARRAY OF TEXT{"OMG","Bye"};
  
PROCEDURE Lower(text:TEXT):TEXT =
  VAR
    Res:TEXT := "";
  BEGIN
    FOR I := 0 TO Text.Length(text)-1 DO
      Res := Text.Cat(Res, Text.FromChar(ASCII.Lower[Text.GetChar(text, I)]));
    END;
    RETURN Res;
  END Lower;

PROCEDURE AllMatch(VAR text:TEXT;VAR S:SET OF CHAR):BOOLEAN =
  BEGIN
    FOR I := 0 TO Text.Length(text)-1 DO
      IF NOT Text.GetChar(text,I) IN S THEN RETURN FALSE END
    END;
    RETURN TRUE;
  END AllMatch;
  
PROCEDURE KeyboardWord(VAR A:ARRAY OF TEXT) =
VAR
  S1:SET OF CHAR := SET OF CHAR{'q','w','e','r','t','y','u','i','o','p'};
  S2:SET OF CHAR := SET OF CHAR{'a','s','d','f','g','h','j','k','l'};
  S3:SET OF CHAR := SET OF CHAR{'z','x','c','v','b','n','m'};
BEGIN
  FOR I := FIRST(A) TO LAST(A) DO A[I] := Lower(A[I]) END;
  FOR I := FIRST(A) TO LAST(A) DO
    IF AllMatch(A[I],S1) OR AllMatch(A[I],S2) OR AllMatch(A[I],S3) THEN
      IO.Put(A[I]);
      IO.PutChar(' ')
    END
  END;
  IO.Put("\n");
END KeyboardWord;

BEGIN
  KeyboardWord(A1);
  KeyboardWord(A2);
END Ch1.

