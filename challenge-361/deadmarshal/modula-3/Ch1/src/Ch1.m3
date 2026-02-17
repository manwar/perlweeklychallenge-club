MODULE Ch1 EXPORTS Main;

IMPORT SIO,IntSeq;

PROCEDURE Fibos(READONLY N:INTEGER):IntSeq.T =
  VAR
    Fs := NEW(IntSeq.T).init();
  BEGIN
    Fs.addhi(1);
    Fs.addhi(2);
    WHILE Fs.get(Fs.size()-1) + Fs.get(Fs.size()-2) <= N DO
      Fs.addhi(Fs.get(Fs.size()-1) + Fs.get(Fs.size()-2));
    END;
    RETURN Fs
  END Fibos;
  
PROCEDURE ZeckendorfRepresentation(READONLY N:INTEGER):IntSeq.T =
  VAR
    Fibs := Fibos(N);
    Parts := NEW(IntSeq.T).init();
    I := Fibs.size()-1;
    Rem := N;
  BEGIN
    WHILE Rem # 0 DO
      IF Fibs.get(I) <= Rem THEN
        Parts.addhi(Fibs.get(I));
        DEC(Rem,Fibs.get(I));
        DEC(I,2)
      ELSE
        DEC(I)
      END;
    END;
    RETURN Parts
  END ZeckendorfRepresentation;

PROCEDURE PrintSeq(READONLY S:IntSeq.T) =
  BEGIN
    FOR I := 0 TO S.size()-1 DO
      SIO.PutInt(S.get(I));
      SIO.PutChar(' ')
    END;
    SIO.Nl();
  END PrintSeq;
  
BEGIN
  PrintSeq(ZeckendorfRepresentation(4));
  PrintSeq(ZeckendorfRepresentation(12));
  PrintSeq(ZeckendorfRepresentation(20));
  PrintSeq(ZeckendorfRepresentation(96));
  PrintSeq(ZeckendorfRepresentation(100))
END Ch1.

