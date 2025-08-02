MODULE Ch2 EXPORTS Main;

IMPORT SIO,ASCII,Text,TextSeq,TextConv;

PROCEDURE FindThird(READONLY Sentence,First,Second:TEXT):TextSeq.T =
  VAR
    Ret := NEW(TextSeq.T).init();
    Words := NEW(REF ARRAY OF TEXT,TextConv.ExplodedSize(Sentence,SET OF CHAR{' '}));
  BEGIN
    TextConv.Explode(Sentence,Words^,SET OF CHAR{' '});
    FOR I := FIRST(Words^) TO LAST(Words^)-1 DO
      IF Text.Equal(Words[I],First) AND Text.Equal(Words[I+1],Second) THEN
        WITH STLI = Text.Length(Words[I+2])-1 DO
          IF NOT Text.GetChar(Words[I+2],STLI) IN ASCII.Letters THEN
            Ret.addhi(Text.Sub(Words[I+2],0,STLI))
          ELSE
            Ret.addhi(Words[I+2])
          END
        END
      END
    END;
    RETURN Ret
  END FindThird;
 
PROCEDURE PrintSeq(READONLY S:TextSeq.T) =
  BEGIN
    FOR I := 0 TO S.size()-1 DO
      SIO.PutText(S.get(I));
      SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintSeq;

BEGIN
  PrintSeq(FindThird("Perl is a my favourite language but " &
    "Python is my favourite too.",
    "my","favourite"));
  PrintSeq(FindThird("Barbie is a beautiful doll also also a " &
    "beautiful princess.",
    "a","beautiful"));
  PrintSeq(FindThird("we will we will rock you rock you.",
                     "we","will"))
END Ch2.

