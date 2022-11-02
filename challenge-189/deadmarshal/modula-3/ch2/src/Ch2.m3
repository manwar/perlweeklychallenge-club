MODULE Ch2 EXPORTS Main;

IMPORT IO;

VAR
  A1:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{1,3,3,2};
  A2:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{1,2,1,3};
  A3:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{1,3,2,1,2};
  A4:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{1,1,2,3,2};
  A5:ARRAY[0..4] OF INTEGER := ARRAY OF INTEGER{2,1,2,1,1};
   
PROCEDURE ArrayDegree(VAR Arr:ARRAY OF INTEGER) = 
  VAR
    Left,Count:ARRAY[0..9] OF INTEGER;
    X,Min,Max,Index:INTEGER := 0;
  BEGIN
    FOR I := FIRST(Arr) TO LAST(Arr) DO
      X := Arr[I];
      IF Count[X] = 0 THEN
        Left[X] := I;
        Count[X] := 1;
      ELSE
        Count[X] := Count[X] + 1;
      END;

      IF Count[X] > Max THEN
        Max := Count[X];
        Min := I - Left[X] + 1;
        Index := Left[X];
      ELSIF((Count[X] = Max) AND (I - Left[X] + 1 < Min)) THEN
        Min := I - Left[X] + 1;
        Index := Left[X];
      END;
    END;

    FOR I := Index TO Index+Min-1 DO
      IO.PutInt(Arr[I]);
      IO.PutChar(' ');
    END;
    IO.Put("\n");
  END ArrayDegree;

BEGIN
  ArrayDegree(A1);
  ArrayDegree(A2);
  ArrayDegree(A3);
  ArrayDegree(A4);
  ArrayDegree(A5);
END Ch2.

