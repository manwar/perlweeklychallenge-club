MODULE Ch1 EXPORTS Main;

IMPORT IO;

PROCEDURE HasSameDigits(N1,N2:INTEGER):BOOLEAN =
  VAR
    Digits:ARRAY[0..9] OF INTEGER :=
        ARRAY OF INTEGER{0,0,0,0,0,0,0,0,0,0};
  BEGIN
    WHILE(N1 # 0) DO
      INC(Digits[N1 MOD 10]);
      N1 := N1 DIV 10;
    END;
    WHILE(N2 # 0) DO
      DEC(Digits[N2 MOD 10]);
      N2 := N2 DIV 10;
    END;
    FOR I := FIRST(Digits) TO LAST(Digits) DO
      IF(Digits[I] # 0) THEN RETURN FALSE; END;
    END;
    RETURN TRUE;
  END HasSameDigits;

PROCEDURE SmallestPermutedMultiplies():INTEGER =
  VAR
    I:INTEGER := 10;
    Found:BOOLEAN;
  BEGIN
    WHILE TRUE DO
      Found := TRUE;
      FOR J := 2 TO 6 DO
        IF NOT(HasSameDigits(I, I * J)) THEN
          Found := FALSE;
          EXIT;
        END;
      END;
      IF Found THEN RETURN I; END;
      INC(I);
    END;
  END SmallestPermutedMultiplies;
  
BEGIN
  IO.PutInt(SmallestPermutedMultiplies());
END Ch1.
