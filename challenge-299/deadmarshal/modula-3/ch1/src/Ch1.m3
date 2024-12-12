MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text,TextIntTbl,TextConv;

VAR
  A1 := ARRAY[0..2] OF TEXT{"cat","bat","rat"};
  A2 := ARRAY[0..2] OF TEXT{"a","b","c"};
  A3 := ARRAY[0..1] OF TEXT{"man","bike"};
  
PROCEDURE ReplaceWords(VAR A:ARRAY OF TEXT;
                       READONLY Sentence:TEXT):TEXT =
  VAR
    Size:CARDINAL := TextConv.ExplodedSize(Sentence,SET OF CHAR{' '});
    Words := NEW(REF ARRAY OF TEXT,Size);
    Roots := NEW(TextIntTbl.Default).init();
    V:INTEGER;
  BEGIN
    TextConv.Explode(Sentence,Words^,SET OF CHAR{' '});
    FOR I := FIRST(A) TO LAST(A) DO EVAL Roots.put(A[I],1) END;
    FOR I := FIRST(Words^) TO LAST(Words^) DO
      FOR J := 1 TO Text.Length(Words[I]) DO
        WITH Sub = Text.Sub(Words[I],0,J) DO
          IF Roots.get(Sub,V) THEN
            Words[I] := Sub;
            EXIT
          END
        END
      END
    END;
    RETURN TextConv.Implode(Words^,' ')
  END ReplaceWords;

BEGIN
  SIO.PutText(ReplaceWords(A1,"the cattle was rattle by the battery") & "\n");
  SIO.PutText(ReplaceWords(A2,"aab aac and cac bab") & "\n");
  SIO.PutText(ReplaceWords(A3,"the manager was hit by a biker") & "\n");
END Ch1.

