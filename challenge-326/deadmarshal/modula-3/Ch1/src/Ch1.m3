MODULE Ch1 EXPORTS Main;

IMPORT SIO,Scan,Text,Lex,FloatMode;
FROM StableError IMPORT Halt;

PROCEDURE IsLeapYear(Y:CARDINAL):BOOLEAN =
  BEGIN
    RETURN Y MOD 4 = 0 AND Y MOD 100 # 0 OR Y MOD 400 = 0
  END IsLeapYear;

PROCEDURE DayOfTheYear(READONLY Date:TEXT):CARDINAL
  RAISES{FloatMode.Trap,Lex.Error} =
  CONST
    Days = ARRAY[0..1],[0..12] OF CARDINAL{
    ARRAY[0..12] OF CARDINAL{0,0,31,59,90,120,151,181,212,243,273,304,334},
    ARRAY[0..12] OF CARDINAL{0,0,31,60,91,121,152,182,213,244,274,305,335}};
  VAR
    Month,Day,Year:CARDINAL;
  BEGIN
    Year := Scan.Int(Text.Sub(Date,0,4));
    Month := Scan.Int(Text.Sub(Date,5,2));
    Day := Scan.Int(Text.Sub(Date,8,2));
    RETURN Days[ORD(IsLeapYear(Year)),Month] + Day;
  END DayOfTheYear;
  
BEGIN
  TRY 
    SIO.PutInt(DayOfTheYear("2025-02-02")); SIO.Nl();
    SIO.PutInt(DayOfTheYear("2025-04-10")); SIO.Nl();
    SIO.PutInt(DayOfTheYear("2025-09-07")); SIO.Nl()
  EXCEPT
    FloatMode.Trap => Halt("FloatMode.Trap")
  | Lex.Error => Halt("Failed lexing text")
  ELSE
    Halt("Some other exception!")
  END;
END Ch1.

