MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE BackspaceCompare(READONLY S1,S2:TEXT):BOOLEAN =
  VAR
    I := Text.Length(S1)-1;
    J := Text.Length(S2)-1;
    Skip1,Skip2:CARDINAL;
  BEGIN
    WHILE I >= 0 OR J >= 0 DO
      WHILE I >= 0 DO
        IF Text.GetChar(S1,I) = '#' THEN
          INC(Skip1);
          DEC(I)
        ELSIF Skip1 > 0 THEN
          DEC(Skip1);
          DEC(I)
        ELSE EXIT
        END
      END;
      WHILE J >= 0 DO
        IF Text.GetChar(S2,J) = '#' THEN
          INC(Skip2);
          DEC(J);
        ELSIF Skip2 > 0 THEN
          DEC(Skip2);
          DEC(J)
        ELSE EXIT
        END
      END;
      IF I >= 0 AND J >= 0 THEN
        IF Text.GetChar(S1,I) # Text.GetChar(S2,J) THEN
          RETURN FALSE
        END;
      ELSIF I >= 0 OR J >= 0 THEN RETURN FALSE 
      END;
      DEC(I);
      DEC(J);
    END;
    RETURN TRUE
  END BackspaceCompare;

BEGIN
  SIO.PutBool(BackspaceCompare("ab#c","ad#c")); SIO.Nl();
  SIO.PutBool(BackspaceCompare("ab##","a#b#")); SIO.Nl();
  SIO.PutBool(BackspaceCompare("a#b","c")); SIO.Nl()
END Ch2.

