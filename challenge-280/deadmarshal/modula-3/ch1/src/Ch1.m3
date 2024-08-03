MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE TwiceAppearance(READONLY Str:TEXT):CHAR =
  VAR
    Counts:ARRAY[0..26] OF INTEGER := ARRAY[0..26] OF INTEGER{0,..};
    Idx:INTEGER := 0;
  BEGIN
    FOR I := 0 TO Text.Length(Str)-1 DO
      Idx := ORD(Text.GetChar(Str,I)) - ORD('a');
      IF Counts[Idx] # 0 THEN RETURN Text.GetChar(Str,I) END;
      INC(Counts[Idx])
    END;
    RETURN '\000'
  END TwiceAppearance;
  
BEGIN
  SIO.PutChar(TwiceAppearance("acbddbca")); SIO.Nl();
  SIO.PutChar(TwiceAppearance("abccd")); SIO.Nl();
  SIO.PutChar(TwiceAppearance("abcdabbb")); SIO.Nl()
END Ch1.

