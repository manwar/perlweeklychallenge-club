MODULE Ch1 EXPORTS Main;

IMPORT IO;

PROCEDURE HasDups(N:INTEGER):BOOLEAN = 
  VAR
    Hash := ARRAY[0..9] OF INTEGER{0,..};
  BEGIN
    IF N > 9999999999 THEN RETURN TRUE END;
    WHILE N # 0 DO
      IF Hash[N MOD 10] # 0 THEN RETURN TRUE END;
      Hash[N MOD 10] := 1;
      N := N DIV 10;
    END;
    RETURN FALSE;
  END HasDups;
  
PROCEDURE SpecialIntegers(N:INTEGER):INTEGER = 
  VAR Count:INTEGER;
  BEGIN
    Count := 0;
    FOR I := 1 TO N DO IF NOT HasDups(I) THEN INC(Count) END END;
    RETURN Count;
  END SpecialIntegers;
  
BEGIN
  IO.PutInt(SpecialIntegers(15)); IO.Put("\n");
  IO.PutInt(SpecialIntegers(35)); IO.Put("\n");
END Ch1.

