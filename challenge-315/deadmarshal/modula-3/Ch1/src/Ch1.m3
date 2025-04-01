MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text,IntSeq;

PROCEDURE FindWords(READONLY A:ARRAY OF TEXT;
                    READONLY C:CHAR):IntSeq.T =
  VAR S := NEW(IntSeq.T).init();
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      IF Text.FindChar(A[I],C) # -1 THEN S.addhi(I) END
    END;
    RETURN S
  END FindWords;

PROCEDURE PrintSeq(READONLY S:IntSeq.T) =
  BEGIN
    FOR I := 0 TO S.size()-1 DO
      SIO.PutInt(S.get(I));
      SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintSeq;
  
BEGIN
  PrintSeq(FindWords(ARRAY OF TEXT{"the","weekly","challenge"},'e'));
  PrintSeq(FindWords(ARRAY OF TEXT{"perl","raku","python"},'p'));
  PrintSeq(FindWords(ARRAY OF TEXT{"abc","def","bbb","bcd"},'b'))
END Ch1.

