MODULE Ch1;

  IMPORT Out,DS := DynamicString;

  VAR
    A1,A2,A3,A4:ARRAY 2 OF DS.DynamicString;
    A5:ARRAY 3 OF DS.DynamicString;
    A6:ARRAY 1 OF DS.DynamicString;
    
  PROCEDURE Init;
    VAR i:LONGINT;
  BEGIN
    FOR i := 0 TO LEN(A1)-1 DO
      A1[i] := DS.Create();
      A2[i] := DS.Create();
      A3[i] := DS.Create();
      A4[i] := DS.Create();
    END;
    FOR i := 0 TO LEN(A5)-1 DO A5[i] := DS.Create() END;
    FOR i := 0 TO LEN(A6)-1 DO A6[i] := DS.Create() END;
    DS.Append(A1[0],"ab"); DS.Append(A1[1],"c");
    DS.Append(A2[0],"a");  DS.Append(A2[1],"bc");
    DS.Append(A3[0],"ab"); DS.Append(A3[1],"c");
    DS.Append(A4[0],"ac"); DS.Append(A4[1],"b");
    DS.Append(A5[0],"ab"); DS.Append(A5[1],"cd"); DS.Append(A5[2],"e");
    DS.Append(A6[0],"abcde");
  END Init;

  PROCEDURE SameString(VAR arr1,arr2:ARRAY OF DS.DynamicString):BOOLEAN;
    VAR
      i:LONGINT;
      s1,s2:DS.DynamicString;
  BEGIN
    s1 := DS.Create(); s2 := DS.Create();
    FOR i := 0 TO LEN(arr1)-1 DO DS.Append(s1,arr1[i].data^) END;
    FOR i := 0 TO LEN(arr2)-1 DO DS.Append(s2,arr2[i].data^) END;
    RETURN DS.Equals(s1,s2)
  END SameString;

  PROCEDURE PrintBool(b:BOOLEAN);
  BEGIN
    IF b THEN Out.String("TRUE"); Out.Ln ELSE Out.String("FALSE"); Out.Ln END
  END PrintBool;
  
BEGIN
  Init;
  PrintBool(SameString(A1,A2));
  PrintBool(SameString(A3,A4));
  PrintBool(SameString(A5,A6));
END Ch1.

