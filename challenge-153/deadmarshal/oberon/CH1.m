MODULE CH1;

(*
Compile with:
$ obc -o CH1 CH1.m 
Compiler:
  https://spivey.oriel.ox.ac.uk/corner/Oxford_Oberon-2_compiler
*)

IMPORT Out;

PROCEDURE Factorial(N:INTEGER):INTEGER;
BEGIN
     IF(N = 0) THEN RETURN 1
     ELSE RETURN N * Factorial(N-1) END;
END Factorial;

PROCEDURE LeftFactorial(N:INTEGER):INTEGER;
VAR
     Sum,I:INTEGER;  
BEGIN
     Sum := 0;
     FOR I := 0 TO N-1 DO
	  Sum := Sum + Factorial(I);
     END;
     RETURN Sum;
END LeftFactorial;

VAR
     I:INTEGER;
BEGIN
     FOR I := 1 TO 10 DO
	  Out.Int(LeftFactorial(I), 2);
	  Out.String(' ');
     END;
END CH1.
