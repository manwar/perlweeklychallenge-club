MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text,Scan,ASCII,FloatMode;
IMPORT Lex,TextConv,Integer;
IMPORT TextIntPair,TextIntPairArraySort;
  
PROCEDURE ExtractAlphas(READONLY Str:TEXT):TEXT =
  VAR Ret:TEXT := "";
  BEGIN
    FOR I := 0 TO Text.Length(Str)-1 DO
      WITH C = Text.GetChar(Str,I) DO 
        IF C IN ASCII.Letters THEN
          Ret := Ret & Text.FromChar(C)
        END
      END
    END;
    RETURN Ret
  END ExtractAlphas;

PROCEDURE ExtractDigits(READONLY Str:TEXT):INTEGER
  RAISES{Lex.Error,FloatMode.Trap} =
  VAR
    Acc:TEXT := "";
    Ret:INTEGER := 0;
  BEGIN
    FOR I := 0 TO Text.Length(Str)-1 DO
      WITH C = Text.GetChar(Str,I) DO
        IF C IN ASCII.Digits THEN
          Acc := Acc & Text.FromChar(C)
        END
      END
    END;
    Ret := Scan.Int(Acc);
    RETURN Ret
  END ExtractDigits;

PROCEDURE Compare(READONLY a,b:TextIntPair.T):[-1..1] =
VAR
  X:INTEGER := TextIntPair.Second(a);
  Y:INTEGER := TextIntPair.Second(b);
BEGIN
  IF Integer.Compare(X,Y) < 0 THEN RETURN -1
  ELSIF Integer.Compare(X,Y) > 0 THEN RETURN 1
  ELSE RETURN 0
  END;
END Compare;

PROCEDURE SortString(READONLY Str:TEXT):TEXT
  RAISES{Lex.Error,FloatMode.Trap} =
  VAR
    Len:CARDINAL := TextConv.ExplodedSize(Str,SET OF CHAR{' '});
    Words:REF ARRAY OF TEXT := NEW(REF ARRAY OF TEXT,Len);
    Pairs:REF ARRAY OF TextIntPair.T :=
        NEW(REF ARRAY OF TextIntPair.T,Len);
  BEGIN
    TextConv.Explode(Str,Words^,SET OF CHAR{' '});
    FOR I := FIRST(Words^) TO LAST(Words^) DO
      Pairs[I] := TextIntPair.Create(ExtractAlphas(Words[I]),
                                     ExtractDigits(Words[I]))
    END;
    TextIntPairArraySort.Sort(Pairs^,Compare);
    FOR I := FIRST(Pairs^) TO LAST(Pairs^) DO
      Words[I] := TextIntPair.First(Pairs[I])
    END;
    RETURN TextConv.Implode(Words^,' ')
  END SortString;
  
BEGIN
  TRY
    SIO.PutText(SortString("and2 Raku3 cousins5 Perl1 are4") & "\n");
    SIO.PutText(SortString("guest6 Python1 most4 the3 popular5 is2 language7")
    & "\n");
    SIO.PutText(SortString("Challenge3 The1 Weekly2") & "\n")
  EXCEPT
    Lex.Error => SIO.PutText("Lex.Error: malformed digit!\n")
  | FloatMode.Trap(t) =>
    CASE t OF
      FloatMode.Flag.Invalid =>
      SIO.PutText("FloatMode.Trap(Invalid)")
    | FloatMode.Flag.Inexact =>
      SIO.PutText("FloatMode.Trap(Inexact)")
    | FloatMode.Flag.Overflow =>
      SIO.PutText("FloatMode.Trap(Overflow)")
    | FloatMode.Flag.Underflow =>
      SIO.PutText("FloatMode.Trap(Underflow)")
    | FloatMode.Flag.DivByZero =>
      SIO.PutText("FloatMode.Trap(DivByZero)")
    | FloatMode.Flag.IntOverflow =>
      SIO.PutText("FloatMode.Trap(IntOverflow)")
    | FloatMode.Flag.IntDivByZero =>
      SIO.PutText("FloatMode.Trap(IntDivByZero)")
    ELSE
        SIO.PutText("Some other exception occurred!\n")
    END
  END;
END Ch1.

