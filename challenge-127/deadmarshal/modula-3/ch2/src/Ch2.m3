MODULE Ch2 EXPORTS Main;

IMPORT IO;
FROM Fmt IMPORT F,Int;

TYPE
  Interval = RECORD
    X,Y:INTEGER;
  END;

VAR
  A1:ARRAY[0..4] OF Interval := ARRAY OF Interval{Interval{1,4},
                                                  Interval{3,5},
                                                  Interval{6,8},
                                                  Interval{12,13},
                                                  Interval{3,20}};
  A2:ARRAY[0..4] OF Interval := ARRAY OF Interval{Interval{3,4},
                                                  Interval{5,7},
                                                  Interval{6,9},
                                                  Interval{10,12},
                                                  Interval{13,15}};

PROCEDURE ConflictIntervals(VAR Arr:ARRAY OF Interval) =
  VAR B:BOOLEAN;
  BEGIN
    FOR I := FIRST(Arr)+1 TO LAST(Arr) DO
      B := FALSE;
      FOR J := FIRST(Arr) TO I-1 DO
        IF (Arr[I].X >= Arr[J].X) AND (Arr[I].X <= Arr[J].Y) THEN B := TRUE END
      END;
      IF B THEN IO.Put(F("(%s %s) ",Int(Arr[I].X),Int(Arr[I].Y))) END
    END;
    IO.Put("\n")
  END ConflictIntervals;
  
BEGIN
  ConflictIntervals(A1);
  ConflictIntervals(A2);
END Ch2.

