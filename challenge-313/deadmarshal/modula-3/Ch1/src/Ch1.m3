MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE BrokenKeys(READONLY S1,S2:TEXT):BOOLEAN =
  VAR Set1,Set2:SET OF CHAR;
  BEGIN
    FOR I := 0 TO Text.Length(S1)-1 DO
      Set1 := Set1 + SET OF CHAR{Text.GetChar(S1,I)}
    END;
    FOR I := 0 TO Text.Length(S2)-1 DO
      Set2 := Set2 + SET OF CHAR{Text.GetChar(S2,I)}
    END;
    RETURN Set1 <= Set2
  END BrokenKeys;

BEGIN
  SIO.PutBool(BrokenKeys("perl","perrrl")); SIO.Nl();
  SIO.PutBool(BrokenKeys("raku","rrakuuuu")); SIO.Nl();
  SIO.PutBool(BrokenKeys("python","perl")); SIO.Nl();
  SIO.PutBool(BrokenKeys("coffeescript","cofffeescccript")); SIO.Nl()
END Ch1.

