MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text,CharSeq;

PROCEDURE DefragIpAddress(READONLY t:TEXT):TEXT =
  VAR
    Seq:CharSeq.T := NEW(CharSeq.T).init(Text.Length(t));
    A:REF ARRAY OF CHAR;
    C:CHAR;
  BEGIN
    FOR I := 0 TO Text.Length(t)-1 DO
      C := Text.GetChar(t,I);
      IF C = '.' THEN
        Seq.addhi('[');
        Seq.addhi(C);
        Seq.addhi(']')
      ELSE
        Seq.addhi(C)
      END;
    END;
    A := NEW(REF ARRAY OF CHAR,Seq.size());
    FOR I := 0 TO Seq.size()-1 DO A[I] := Seq.get(I) END;
    RETURN Text.FromChars(A^)
  END DefragIpAddress;

BEGIN
  SIO.PutText(DefragIpAddress("1.1.1.1") & "\n");
  SIO.PutText(DefragIpAddress("255.101.1.0") & "\n");
END Ch1.

