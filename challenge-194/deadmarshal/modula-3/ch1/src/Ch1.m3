MODULE Ch1 EXPORTS Main;

IMPORT IO;
FROM Scan IMPORT Int;
FROM Text IMPORT GetChar,FromChar;

PROCEDURE DigitalClock(T:TEXT):CARDINAL =
  BEGIN
    IF GetChar(T,0) = '?' THEN
      IF Int(FromChar(GetChar(T,1))) < 4 THEN RETURN 2 ELSE RETURN 1 END;
    ELSIF GetChar(T,1) = '?' THEN
      IF Int(FromChar(GetChar(T,0))) < 2 THEN RETURN 9 ELSE RETURN 3 END;
    ELSIF GetChar(T,3) = '?' THEN
      RETURN 5
    ELSE
      RETURN 9
    END;
  END DigitalClock;
  
BEGIN
  IO.PutInt(DigitalClock("?5:00")); IO.Put("\n");
  IO.PutInt(DigitalClock("?3:00")); IO.Put("\n");
  IO.PutInt(DigitalClock("1?:00")); IO.Put("\n");
  IO.PutInt(DigitalClock("2?:00")); IO.Put("\n");
  IO.PutInt(DigitalClock("12:?5")); IO.Put("\n");
  IO.PutInt(DigitalClock("12:5?")); IO.Put("\n");
END Ch1.

