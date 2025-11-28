MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE MeetingPoint(READONLY S:TEXT):BOOLEAN =
  VAR X,Y:INTEGER;
  BEGIN
    FOR I := 0 TO Text.Length(S)-1 DO
      WITH C = Text.GetChar(S,I) DO
        CASE C OF
          'U' => INC(Y)
          | 'R' => INC(X)
          | 'D' => DEC(Y)
          | 'L' => DEC(X)
          ELSE
            (* ignored *)
          END
      END
    END;
    RETURN X = 0 AND Y = 0
  END MeetingPoint;

BEGIN
  SIO.PutBool(MeetingPoint("ULD")); SIO.Nl();
  SIO.PutBool(MeetingPoint("ULDR")); SIO.Nl();
  SIO.PutBool(MeetingPoint("UUURRRDDD")); SIO.Nl();
  SIO.PutBool(MeetingPoint("UURRRDDLLL")); SIO.Nl();
  SIO.PutBool(MeetingPoint("RRUULLDDRRUU")); SIO.Nl()
END Ch2.

