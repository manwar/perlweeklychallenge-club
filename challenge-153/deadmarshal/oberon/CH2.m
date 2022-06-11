MODULE CH2;

(*
Compile with:
$ obc -o CH2 CH2.m 
Compiler:
  https://spivey.oriel.ox.ac.uk/corner/Oxford_Oberon-2_compiler
*)

IMPORT Out;

PROCEDURE Factorial(N:INTEGER):INTEGER;
BEGIN
     IF(N = 0) THEN RETURN 1
     ELSE RETURN N * Factorial(N-1) END;
END Factorial;

PROCEDURE Factorions(N:INTEGER):INTEGER;
VAR
     Copy,Sum:INTEGER;
BEGIN
     Copy := N;
     Sum := 0;
     REPEAT
	  Sum := Sum + Factorial(Copy MOD 10);
	  Copy := Copy DIV 10;
     UNTIL(Copy = 0);
     
     IF Sum = N THEN RETURN 1 ELSE RETURN 0 END;
END Factorions;

BEGIN
     Out.String("145: "); Out.Int(Factorions(145), 1); Out.Ln;
     Out.String("123: "); Out.Int(Factorions(123), 1); Out.Ln;
END CH2.
