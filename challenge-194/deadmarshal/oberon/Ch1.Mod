MODULE Ch1;

  IMPORT Out;
 
  PROCEDURE DigitalClock(Str:ARRAY OF CHAR):INTEGER;
  BEGIN
    IF Str[0] = '?' THEN
      IF ORD(Str[1]) - ORD('0') < 4 THEN RETURN 2 ELSE RETURN 1 END;
    ELSIF Str[1] = '?' THEN
      IF ORD(Str[0]) - ORD('0') < 2 THEN RETURN 9 ELSE RETURN 3 END;
    ELSIF Str[3] = '?' THEN
      RETURN 5
    ELSE
      RETURN 9;
    END;
  END DigitalClock;
  
BEGIN
  Out.Int(DigitalClock("?5:00"),0); Out.Ln;
  Out.Int(DigitalClock("?3:00"),0); Out.Ln;
  Out.Int(DigitalClock("1?:00"),0); Out.Ln;
  Out.Int(DigitalClock("2?:00"),0); Out.Ln;
  Out.Int(DigitalClock("12:?5"),0); Out.Ln;
  Out.Int(DigitalClock("12:5?"),0); Out.Ln;
END Ch1.

