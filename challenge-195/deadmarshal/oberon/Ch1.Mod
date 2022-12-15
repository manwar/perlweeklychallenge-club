MODULE Ch1;

  IMPORT Out;

  PROCEDURE HasDups(N:INTEGER):BOOLEAN;
    VAR
      I:LONGINT;
      Hash:ARRAY 10 OF INTEGER;
  BEGIN
    FOR I := 0 TO LEN(Hash)-1 DO Hash[I] := 0 END;
    IF N > 9999999999 THEN RETURN TRUE END;
    WHILE N # 0 DO
      IF Hash[N MOD 10] # 0 THEN RETURN TRUE END;
      Hash[N MOD 10] := 1;
      N := N DIV 10;
    END;
    RETURN FALSE;
  END HasDups;
  
  PROCEDURE SpecialIntegers(N:INTEGER):INTEGER;
    VAR I,Count:INTEGER;
  BEGIN
    Count := 0;
    FOR I := 1 TO N DO IF ~HasDups(I) THEN INC(Count) END END;
    RETURN Count;
  END SpecialIntegers;
  
BEGIN
  Out.Int(SpecialIntegers(15),0); Out.Ln;
  Out.Int(SpecialIntegers(35),0); Out.Ln;
END Ch1.

