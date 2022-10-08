MODULE Ch2;

IMPORT Out;
    
TYPE
  PArr = POINTER TO ARRAY OF ARRAY OF CHAR;
VAR
  I,J:LONGINT;
  List,List2:PArr;

PROCEDURE Init;
BEGIN
  NEW(List, 3, 13);
  NEW(List2, 3, 12);
  COPY("ab-cde-123", List[0]);
  COPY("123.abc.420", List[1]);
  COPY("3abc-0010.xy", List[2]);
  COPY("1234567.a", List2[0]);
  COPY("a-1234-bc", List2[1]);
  COPY("a.b.c.d.e.f", List2[2]); 
END Init;

PROCEDURE IsAlpha(C:CHAR):BOOLEAN;
VAR
  Alphabet:ARRAY 54 OF CHAR;
BEGIN
  COPY("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", Alphabet);
  FOR I := 0 TO LEN(Alphabet)-1 DO
    IF(C = Alphabet[I]) THEN RETURN TRUE END;
  END;
  RETURN FALSE;
END IsAlpha;

PROCEDURE IsDigit(C:CHAR):BOOLEAN;
VAR
  Digits:ARRAY 11 OF CHAR;
BEGIN
  COPY("0123456789", Digits);
  FOR I := 0 TO LEN(Digits)-1 DO
    IF(C = Digits[I]) THEN RETURN TRUE END;
  END;
  RETURN FALSE;
END IsDigit;

PROCEDURE MaskCode(Arr:PArr);
VAR
  I,J,Count:LONGINT;
BEGIN
  Count := 0;
  FOR I := 0 TO LEN(Arr^)-1 DO
    J := 0;
    Count := 0;
    LOOP
      IF((IsAlpha(Arr[I,J])) OR (IsDigit(Arr[I,J]))) THEN
	Arr[I,J] := 'x';
	INC(Count);
      END;
      INC(J);
      IF Count = 4 THEN EXIT END;
    END;
  END;
END MaskCode;

BEGIN
  Init;
  MaskCode(List);
  MaskCode(List2);
  FOR I := 0 TO LEN(List^)-1 DO
    Out.String(List[I]);
    Out.Char(' ');
  END;
  Out.Ln;
  FOR I := 0 TO LEN(List2^)-1 DO
    Out.String(List2[I]);
    Out.Char(' ');
  END;
  Out.Ln;
END Ch2.
  
