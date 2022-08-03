MODULE Ch1 EXPORTS Main;

IMPORT IO,Scan,Params,StableError,Lex,FloatMode;
FROM Fmt IMPORT F,Int;

VAR
  Input:INTEGER;

PROCEDURE IsLeapYear(Year:INTEGER):BOOLEAN =
  BEGIN
    IF Year MOD 100 = 0 THEN RETURN Year MOD 400 = 0; END;
    RETURN Year MOD 4 = 0;
  END IsLeapYear;
  
PROCEDURE LastSunday(Year:INTEGER) =
  VAR
    Week:INTEGER;
    Days:ARRAY[1..12] OF INTEGER := ARRAY OF INTEGER{31,28,31,30,31,30,31,31,30,31,30,31};
  BEGIN
    IF IsLeapYear(Year) THEN Days[2] := 29; END;
    Week := Year * 365 + 96 * (Year - 1) DIV 400 + 4;
    FOR Month := FIRST(Days) TO LAST(Days) DO
      Week := (Week + Days[Month]) MOD 7;
      IO.Put(F("%s-%02s-%s\n", Int(Year), Int(Month), Int(Days[Month] - Week)));
    END;
  END LastSunday;

BEGIN
  IF Params.Count # 2 THEN StableError.Halt("No arg(s) provided!"); END;
  TRY
    Input := Scan.Int(Params.Get(1));
  EXCEPT
  | Lex.Error =>
    StableError.Halt("Lex.Error occured!");
  | FloatMode.Trap =>
    StableError.Halt("Floatmode.Error occured!");
  END;
  LastSunday(Input);
END Ch1.
