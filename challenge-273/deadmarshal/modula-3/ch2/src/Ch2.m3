MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE FindChar(READONLY Str:TEXT;
                   READONLY C:CHAR;
                   READONLY Backwards:BOOLEAN := FALSE):INTEGER =
  BEGIN
    IF Backwards THEN
      FOR I := Text.Length(Str)-1 TO 0 BY -1 DO
        IF Text.GetChar(Str,I) = C THEN RETURN I END
      END
    ELSE
      FOR I := 0 TO Text.Length(Str)-1 DO
        IF Text.GetChar(Str,I) = C THEN RETURN I END
      END      
    END;
    RETURN -1
  END FindChar;
  
PROCEDURE BAfterA(READONLY Str:TEXT):BOOLEAN =
  VAR
    IB:INTEGER := FindChar(Str,'b'); 
    IA:INTEGER := FindChar(Str,'a',TRUE);
  BEGIN
    RETURN IB # -1 AND IA <= IB
  END BAfterA;

BEGIN
  SIO.PutBool(BAfterA("aabb")); SIO.Nl();
  SIO.PutBool(BAfterA("abab")); SIO.Nl();
  SIO.PutBool(BAfterA("aaa")); SIO.Nl();
  SIO.PutBool(BAfterA("bbb")); SIO.Nl();
END Ch2.

