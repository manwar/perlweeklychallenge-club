MODULE Ch1 EXPORTS Main;

IMPORT IO,Params,StableError,Text,Fmt;

PROCEDURE FirstUniqueCharacter(Str:TEXT):TEXT =
  VAR
    Ret:TEXT;
    Chars:REF ARRAY OF CHAR;
    Hash:ARRAY[0..255] OF INTEGER := ARRAY[0..255] OF INTEGER{0, ..};
  BEGIN
    Chars := NEW(REF ARRAY OF CHAR, Text.Length(Str));
    FOR I := 0 TO Text.Length(Str)-1 DO
      Chars[I] := Text.GetChar(Str, I);
    END;
    FOR I := FIRST(Chars^) TO LAST(Chars^) DO
      Hash[ORD(Chars[I])] := Hash[ORD(Chars[I])] + 1;
    END;
    FOR I := FIRST(Chars^) TO LAST(Chars^) DO
      IF Hash[ORD(Chars[I])] = 1 THEN
        Ret := Fmt.F("%s as '%s' is the first unique character\n",
                     Fmt.Int(I),
                     Fmt.Char(Chars[I]));
        EXIT;
      END;
    END;
    RETURN Ret;
  END FirstUniqueCharacter;

BEGIN
  IF Params.Count # 2 THEN
    StableError.Halt("No arg(s) provided!");
  END;
  IO.Put(FirstUniqueCharacter(Params.Get(1)));
END Ch1. 
