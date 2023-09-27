MODULE Ch1;

  IMPORT Out;

  VAR
    A1,A2:ARRAY 5 OF LONGINT;
    A3:ARRAY 4 OF LONGINT;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 5; A1[1] := 5; A1[2] := 5; A1[3] := 10; A1[4] := 20;
    A2[0] := 5; A2[1] := 5; A2[2] := 10; A2[3] := 10; A2[4] := 20;
    A3[0] := 5; A3[1] := 5; A3[2] := 5; A3[3] := 20;
  END Init;

  PROCEDURE ExactExchange(VAR arr:ARRAY OF LONGINT):LONGINT;
    VAR
      i,fives,tens,twenties:LONGINT;
  BEGIN
    fives := 0; tens := 0; twenties := 0;
    FOR i := 0 TO LEN(arr)-1 DO     
      IF arr[i] = 10 THEN
	DEC(fives);
	IF fives = 0 THEN RETURN 0 END
      ELSIF arr[i] = 20 THEN
	IF (fives # 0) & (tens # 0) THEN DEC(fives); DEC(tens)
	ELSIF fives > 2 THEN DEC(fives,3)
	ELSE RETURN 0
	END
      END;
      CASE arr[i] OF
      | 5: INC(fives)
      | 10: INC(tens)
      | 20: INC(twenties)
      ELSE
	Out.String("Only 5,10,20 allowed!"); Out.Ln;
	RETURN 0
      END
    END;
    RETURN 1
  END ExactExchange;
  
BEGIN
  Init;
  Out.Int(ExactExchange(A1),0); Out.Ln;
  Out.Int(ExactExchange(A2),0); Out.Ln;
  Out.Int(ExactExchange(A3),0); Out.Ln;
END Ch1.

