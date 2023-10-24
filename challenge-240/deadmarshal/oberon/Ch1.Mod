MODULE Ch1;

  IMPORT Out,DS := DynamicString,ethStrings;

  VAR
    A1,A3:ARRAY 3 OF DS.DynamicString;
    A2:ARRAY 2 OF DS.DynamicString;
    
  PROCEDURE Init;
    VAR i:LONGINT;
  BEGIN
    FOR i := 0 TO LEN(A1)-1 DO
      A1[i] := DS.Create();
      A3[i] := DS.Create();
    END;
    FOR i := 0 TO LEN(A2)-1 DO A2[i] := DS.Create() END;
    DS.Append(A1[0],"Perl"); DS.Append(A1[1],"Python"); DS.Append(A1[2],"Pascal");
    DS.Append(A2[0],"Perl"); DS.Append(A2[1],"Raku");
    DS.Append(A3[0],"Oracle"); DS.Append(A3[1],"Awk"); DS.Append(A3[2],"C");
  END Init;

  PROCEDURE Acronym(VAR arr:ARRAY OF DS.DynamicString;check:ARRAY OF CHAR):BOOLEAN;
    VAR
      i:LONGINT;
      s1:DS.DynamicString;
  BEGIN
    s1 := DS.Create();
    FOR i := 0 TO LEN(arr)-1 DO
      DS.AppendCharacter(s1,ethStrings.LowerCh(arr[i].data^[0]))
    END;
    RETURN s1.data^ = check
  END Acronym;

  PROCEDURE PrintBool(b:BOOLEAN);
  BEGIN
    IF b THEN Out.String("TRUE"); Out.Ln ELSE Out.String("FALSE"); Out.Ln END
  END PrintBool;

BEGIN
  Init;
  PrintBool(Acronym(A1,"ppp"));
  PrintBool(Acronym(A2,"rp"));
  PrintBool(Acronym(A3,"oac"));
END Ch1.

