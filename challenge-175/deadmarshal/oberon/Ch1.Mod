MODULE Ch1;

  IMPORT In,Out,Args;
    
  VAR
    Input:LONGINT;

  PROCEDURE IsLeapYear(Year:LONGINT):BOOLEAN;
  BEGIN
    IF Year MOD 100 = 0 THEN RETURN Year MOD 400 = 0 END;
    RETURN Year MOD 4 = 0;
  END IsLeapYear;

  PROCEDURE LastSunday(Year:LONGINT);
    VAR
      Week,Month:LONGINT;
      Days:ARRAY 12 OF LONGINT;
  BEGIN
    Days[0] := 31; Days[1] := 28; Days[2] := 31; Days[3] := 30;
    Days[4] := 31; Days[5] := 30; Days[6] := 31; Days[7] := 31;
    Days[8] := 30; Days[9] := 31; Days[10] := 30; Days[11] := 31;
    IF IsLeapYear(Year) THEN Days[2] := 29 END;
    Week := Year * 365 + 96 * (Year - 1) DIV 400 + 4;
    FOR Month := 0 TO 11 DO
      Week := (Week + Days[Month]) MOD 7;
      Out.Int(Year,0); Out.Char('-');
      IF Month+1 < 10 THEN
	Out.Int(0,0);
	Out.Int(Month+1,0);
      ELSE
	Out.Int(Month+1,0);
      END;
      Out.Char('-');
      Out.Int(Days[Month] - Week,0);
      Out.Ln;
    END;
  END LastSunday;
  
BEGIN
  IF Args.argc # 2 THEN
    Out.String("No arg(s) provided!"); Out.Ln;
    HALT(1);
  END;
  Args.GetInt(1,Input);
  LastSunday(Input);
END Ch1.

