MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text,CharIntTbl;

PROCEDURE OddLetters(READONLY S:TEXT):BOOLEAN =
  VAR
    H := NEW(CharIntTbl.Default).init(Text.Length(S));
    It:CharIntTbl.Iterator;
    K:CHAR;
    V:INTEGER;
  BEGIN
    FOR I := 0 TO Text.Length(S)-1 DO
      K := Text.GetChar(S,I);
      IF NOT H.get(K,V) THEN EVAL H.put(K,1)
      ELSE EVAL H.put(K,V+1)
      END
    END;
    It := H.iterate();
    WHILE It.next(K,V) DO
      IF V MOD 2 = 0 THEN RETURN FALSE END
    END;
    RETURN TRUE
  END OddLetters;

BEGIN
  SIO.PutBool(OddLetters("weekly")); SIO.Nl();
  SIO.PutBool(OddLetters("perl")); SIO.Nl();
  SIO.PutBool(OddLetters("challenge")); SIO.Nl()
END Ch2.

