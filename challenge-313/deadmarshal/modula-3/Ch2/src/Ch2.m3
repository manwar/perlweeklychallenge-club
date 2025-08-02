MODULE Ch2 EXPORTS Main;

IMPORT SIO,ASCII,Text;
  
PROCEDURE ReverseLetters(READONLY S:TEXT):TEXT =
  VAR
    Chars := NEW(REF ARRAY OF CHAR,Text.Length(S));
    Temp:CHAR;
    I := FIRST(Chars^);
    J := LAST(Chars^);
  BEGIN
    Text.SetChars(Chars^,S);
    WHILE I < J DO
      WHILE I < J AND NOT Chars[I] IN ASCII.Letters DO INC(I) END;
      WHILE I < J AND NOT Chars[J] IN ASCII.Letters DO DEC(J) END;
      IF I < J THEN
        Temp := Chars[I];
        Chars[I] := Chars[J];
        Chars[J] := Temp;
        INC(I);
        DEC(J)
      END
    END;
    RETURN Text.FromChars(Chars^)
  END ReverseLetters;
  
BEGIN
  SIO.PutText(ReverseLetters("p-er?l")); SIO.Nl();
  SIO.PutText(ReverseLetters("wee-k!L-y")); SIO.Nl();
  SIO.PutText(ReverseLetters("_c-!h_all-en!g_e")); SIO.Nl()
END Ch2.

