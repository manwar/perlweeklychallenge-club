MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE FriendlyStrings(READONLY S1,S2:TEXT):BOOLEAN =
  VAR
    Set1,Set2:SET OF CHAR;
  BEGIN
    FOR I := 0 TO Text.Length(S1)-1 DO
      Set1 := Set1 + SET OF CHAR{Text.GetChar(S1,I)}
    END;
    FOR I := 0 TO Text.Length(S2)-1 DO
      Set2 := Set2 + SET OF CHAR{Text.GetChar(S2,I)}
    END;
    RETURN Set1 = Set2
  END FriendlyStrings;
  
BEGIN
  SIO.PutBool(FriendlyStrings("desc","dsec")); SIO.Nl();
  SIO.PutBool(FriendlyStrings("fuck","fcuk")); SIO.Nl();
  SIO.PutBool(FriendlyStrings("poo","eop")); SIO.Nl();
  SIO.PutBool(FriendlyStrings("stripe","sprite")); SIO.Nl()
END Ch2.

