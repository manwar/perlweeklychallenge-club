MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE Subsequence(READONLY S1,S2:TEXT):BOOLEAN =
  VAR I,J:INTEGER;
  BEGIN
    WHILE I < Text.Length(S1) AND J < Text.Length(S2) DO
      IF Text.GetChar(S1,I) = Text.GetChar(S2,J) THEN INC(I) END;
      INC(J)
    END;
    RETURN I = Text.Length(S1)
  END Subsequence;
    
BEGIN
  SIO.PutBool(Subsequence("uvw","bcudvew")); SIO.Nl();
  SIO.PutBool(Subsequence("aec","abcde")); SIO.Nl();
  SIO.PutBool(Subsequence("sip","javascript")); SIO.Nl()
END Ch2.

