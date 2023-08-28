MODULE Ch2 EXPORTS Main;

IMPORT IO,Text,Scan,Fmt,FloatMode,Lex;
FROM StableError IMPORT Halt;

VAR
  A1:ARRAY[0..2] OF TEXT := ARRAY OF TEXT{"7868190130M7522",
                                          "5303914400F9211",
                                          "9273338290F4010"};
  A2:ARRAY[0..1] OF TEXT := ARRAY OF TEXT{"1313579440F2036",
                                          "2921522980M5644"};
  
PROCEDURE SeniorCitizens(VAR A:ARRAY OF TEXT):INTEGER =
  VAR
    S:TEXT := "";
    Age,Count:INTEGER := 0;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      S := Text.Sub(A[I],Text.Length(A[I])-4,2);
      TRY
        Age := Scan.Int(S);
      EXCEPT
      | FloatMode.Trap, Lex.Error =>
        Halt("Failed converting the text to integer!\n");
      END;
      IF Age >= 60 THEN INC(Count) END
    END;
    RETURN Count
  END SeniorCitizens;
  
BEGIN
  IO.Put(Fmt.F("%s\n",Fmt.Int(SeniorCitizens(A1))));
  IO.Put(Fmt.F("%s\n",Fmt.Int(SeniorCitizens(A2))));
END Ch2.

