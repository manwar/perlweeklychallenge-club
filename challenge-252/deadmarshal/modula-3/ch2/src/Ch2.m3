MODULE Ch2 EXPORTS Main;

IMPORT SIO;

PROCEDURE UniqueSumZero(READONLY N:INTEGER) = 
  BEGIN
    FOR I := 1 TO N DIV 2 DO 
      SIO.PutInt(I);
      SIO.PutChar(' ');
      SIO.PutInt(-I);
      SIO.PutChar(' ')
    END;
    IF N MOD 2 = 1 THEN SIO.PutInt(0); SIO.Nl() END
  END UniqueSumZero;

BEGIN
  UniqueSumZero(5);
  UniqueSumZero(3);
  UniqueSumZero(1);
END Ch2.
