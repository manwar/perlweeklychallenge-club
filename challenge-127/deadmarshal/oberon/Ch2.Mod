MODULE Ch2;

  IMPORT Out;

  TYPE
    Interval = RECORD
      x*,y*:LONGINT;
    END;

  VAR
    A1,A2:ARRAY 5 OF Interval;
    
  PROCEDURE Init;
  BEGIN
    A1[0].x := 1; A1[0].y := 4; A1[1].x := 3; A1[1].y := 5;
    A1[2].x := 6; A1[2].y := 8; A1[3].x := 12; A1[3].y := 13;
    A1[4].x := 3; A1[4].y := 20;
    A2[0].x := 3; A2[0].y := 4; A2[1].x := 5; A2[1].y := 7;
    A2[2].x := 6; A2[2].y := 9; A2[3].x := 10; A2[3].y := 12;
    A2[4].x := 13; A2[4].y := 15;
  END Init;

  PROCEDURE ConflictIntervals(VAR arr:ARRAY OF Interval);
    VAR
      i,j:LONGINT;
      b:BOOLEAN;
  BEGIN
    FOR i := 1 TO LEN(arr)-1 DO
      b := FALSE;
      FOR j := 0 TO i-1 DO
	IF (arr[i].x >= arr[j].x) & (arr[i].x <= arr[j].y) THEN b := TRUE END
      END;
      IF b THEN
	Out.Char('('); Out.Int(arr[i].x,0);
	Out.Char(','); Out.Int(arr[i].y,0);
	Out.Char(')'); Out.Char(' ')
      END
    END;
    Out.Ln
  END ConflictIntervals;

BEGIN
  Init;
  ConflictIntervals(A1);
  ConflictIntervals(A2);
END Ch2.

