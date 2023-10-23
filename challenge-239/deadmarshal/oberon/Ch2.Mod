MODULE Ch2;

  IMPORT Out,DS := DynamicString;

  VAR 
    A1:ARRAY 5 OF DS.DynamicString;
    A2:ARRAY 7 OF DS.DynamicString;
    A3:ARRAY 8 OF DS.DynamicString;
    
  PROCEDURE Init;
    VAR i:LONGINT;
  BEGIN
    FOR i := 0 TO LEN(A1)-1 DO A1[i] := DS.Create() END;
    FOR i := 0 TO LEN(A2)-1 DO A2[i] := DS.Create() END;
    FOR i := 0 TO LEN(A3)-1 DO A3[i] := DS.Create() END;
    DS.Append(A1[0],"ad"); DS.Append(A1[1],"bd"); DS.Append(A1[2],"aaab");
    DS.Append(A1[3],"baa"); DS.Append(A1[4],"badab");
    DS.Append(A2[0],"a"); DS.Append(A2[1],"b"); DS.Append(A2[2],"c");
    DS.Append(A2[3],"ab"); DS.Append(A2[4],"ac"); DS.Append(A2[5],"bc");
    DS.Append(A2[6],"abc");
    DS.Append(A3[0],"cc"); DS.Append(A3[1],"acd"); DS.Append(A3[2],"b");
    DS.Append(A3[3],"ba"); DS.Append(A3[4],"bac"); DS.Append(A3[5],"bad");
    DS.Append(A3[6],"ac"); DS.Append(A3[7],"d");
  END Init;

  PROCEDURE Pos(VAR str:ARRAY OF CHAR;ch:CHAR):LONGINT;
    VAR i:LONGINT;
  BEGIN
    FOR i := 0 TO LEN(str)-1 DO IF str[i] = ch THEN RETURN i END END;
    RETURN -1
  END Pos;
  
  PROCEDURE ConsistentStrings(VAR arr:ARRAY OF DS.DynamicString;
			      allowed:ARRAY OF CHAR):LONGINT;
    VAR
      i,j,count:LONGINT;
      b:BOOLEAN;
  BEGIN
    count := 0;
    FOR i := 0 TO LEN(arr)-1 DO
      b := TRUE; j := 0;
      LOOP
	IF j >= DS.Length(arr[i]) THEN EXIT END;
	IF Pos(allowed,arr[i].data[j]) = -1 THEN b := FALSE; EXIT END;
	INC(j);
      END;
      IF b THEN INC(count) END
    END;
    RETURN count
  END ConsistentStrings;
  
BEGIN
  Init;
  Out.Int(ConsistentStrings(A1,"ab"),0); Out.Ln;
  Out.Int(ConsistentStrings(A2,"abc"),0); Out.Ln;
  Out.Int(ConsistentStrings(A3,"cad"),0); Out.Ln;
END Ch2.

