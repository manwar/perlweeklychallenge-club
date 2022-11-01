MODULE Ch2;

  IMPORT Out;

  VAR
    I,Count:LONGINT;

  PROCEDURE Phi(N:LONGINT):LONGINT;
    VAR
      I,Result:LONGINT;
  BEGIN
    Result := N;
    I := 2;
    WHILE I <= N DO
      IF N MOD I = 0 THEN
	WHILE N MOD I = 0 DO N := N DIV I END;
	Result := Result - (Result DIV I);
      END;
      IF I = 2 THEN I := 1 END;
      INC(I,2);
    END;
    IF(N > 1) THEN Result := Result - (Result DIV N) END;
    RETURN Result;
  END Phi;

  PROCEDURE PhiIter(N:LONGINT):LONGINT;
  BEGIN
    IF N = 2 THEN RETURN Phi(N) END;
    RETURN Phi(N) + PhiIter(Phi(N));
  END PhiIter;
  
BEGIN
  I := 2;
  Count := 0;
  WHILE Count # 20 DO
    IF I = PhiIter(I) THEN
      Out.Int(I,0);
      Out.Char(' ');
      Out.Flush;
      INC(Count);
    END;
    INC(I);
  END;
END Ch2.

