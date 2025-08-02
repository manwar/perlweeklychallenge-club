MODULE Ch2 EXPORTS Main;

IMPORT SIO,IntSeq,Stdio;

EXCEPTION NotEnoughElements;

VAR 
  A1:ARRAY[0..4] OF CARDINAL := ARRAY OF CARDINAL{2,1,3,4,5};
  A2:ARRAY[0..2] OF CARDINAL := ARRAY OF CARDINAL{3,2,4};
  A3:ARRAY[0..3] OF CARDINAL := ARRAY OF CARDINAL{5,4,3,8};

PROCEDURE DistributeElements(VAR A:ARRAY OF CARDINAL):IntSeq.T
  RAISES{NotEnoughElements} =
  VAR
    I:INTEGER := FIRST(A)+2;
    Ret1,Ret2:IntSeq.T := NEW(IntSeq.T).init();
  BEGIN
    IF NUMBER(A) < 2 THEN RAISE NotEnoughElements END;
    Ret1.addhi(A[FIRST(A)]);
    Ret2.addhi(A[FIRST(A)+1]);
    WHILE(I # NUMBER(A)) DO
      IF Ret1.gethi() > Ret2.gethi() THEN Ret1.addhi(A[I])
      ELSE Ret2.addhi(A[I])
      END;
      INC(I)
    END;
    RETURN IntSeq.Cat(Ret1,Ret2)
  END DistributeElements;

PROCEDURE PrintSequence(READONLY Seq:IntSeq.T) =
  BEGIN
    FOR I := 0 TO Seq.size()-1 DO
      SIO.PutInt(Seq.get(I));
      SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintSequence;
  
BEGIN
  TRY
    PrintSequence(DistributeElements(A1));
    PrintSequence(DistributeElements(A2));
    PrintSequence(DistributeElements(A3));
  EXCEPT
    NotEnoughElements =>
    SIO.PutText("Not enough elements in array!\n",Stdio.stderr)
  ELSE SIO.PutText("Some other exception occurred!\n",Stdio.stderr)
  END;
END Ch2.

