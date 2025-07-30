MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text,TextConv,ASCII;

PROCEDURE Trim(READONLY Str:TEXT):TEXT =
  VAR
    Start:CARDINAL := 0;
    Stop:CARDINAL := Text.Length(Str);
    C:CHAR;
  BEGIN
    WHILE Start < Stop DO
      C := Text.GetChar(Str,Start);
      IF NOT C IN ASCII.Spaces THEN EXIT END;
      INC(Start)
    END;
    WHILE Start < Stop DO
      C := Text.GetChar(Str,Stop-1);
      IF NOT C IN ASCII.Spaces THEN EXIT END;
      DEC(Stop)
    END;
    RETURN Text.Sub(Str,Start,Stop-Start)
  END Trim;

PROCEDURE LastWord(READONLY Str:TEXT):CARDINAL =
  CONST
    S = SET OF CHAR{' ', '\t', '\n', '\r', '\f'};
  VAR
    Trimmed := Trim(Str);
    Len := TextConv.ExplodedSize(Trimmed,S);
    A := NEW(REF ARRAY OF TEXT,Len);
  BEGIN
    TextConv.Explode(Trimmed,A^,S);
    RETURN Text.Length(A[LAST(A^)])
  END LastWord;

BEGIN
  SIO.PutInt(LastWord("The Weekly Challenge")); SIO.Nl();
  SIO.PutInt(LastWord("    Hello World    ")); SIO.Nl();
  SIO.PutInt(LastWord("Let's begin the fun")); SIO.Nl()
END Ch1.

