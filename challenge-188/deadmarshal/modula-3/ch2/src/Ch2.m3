MODULE Ch2 EXPORTS Main;

IMPORT IO;

PROCEDURE TotalZero(X,Y:INTEGER):INTEGER =
  VAR Count:INTEGER := 0;
  BEGIN
    WHILE (X > 0) AND (Y > 0) DO
      IF X >= Y THEN
        X := X - Y;
      ELSE
        Y := Y - X;
      END;
      INC(Count);
    END;
    RETURN Count;
  END TotalZero;
  
BEGIN
  IO.PutInt(TotalZero(5,4)); IO.Put("\n");
  IO.PutInt(TotalZero(4,6)); IO.Put("\n");
  IO.PutInt(TotalZero(2,5)); IO.Put("\n");
  IO.PutInt(TotalZero(3,1)); IO.Put("\n");
  IO.PutInt(TotalZero(7,4)); IO.Put("\n");
END Ch2.

