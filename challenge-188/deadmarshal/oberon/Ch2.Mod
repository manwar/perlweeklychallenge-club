MODULE Ch2;

  IMPORT Out;

  PROCEDURE TotalZero(X,Y:INTEGER):INTEGER;
    VAR
      Count:INTEGER;
  BEGIN
    Count := 0;
    WHILE((X > 0) & (Y > 0)) DO
      IF X >= Y THEN X := X - Y ELSE Y := Y - X END;
      INC(Count);
    END;
    RETURN Count;
  END TotalZero;
  
BEGIN
  Out.Int(TotalZero(5,4),0); Out.Ln;
  Out.Int(TotalZero(4,6),0); Out.Ln;
  Out.Int(TotalZero(2,5),0); Out.Ln;
  Out.Int(TotalZero(3,1),0); Out.Ln;
  Out.Int(TotalZero(7,4),0); Out.Ln;
END Ch2.

