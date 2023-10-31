MODULE DynamicString;

  IMPORT Out,Strings;
    
  CONST
    InitialSize = 256;

  TYPE
    String* = POINTER TO ARRAY OF CHAR;
    DynamicString* = POINTER TO DynamicStringDesc;
    DynamicStringDesc = RECORD
      data*:POINTER TO ARRAY OF CHAR;
      length,capacity:LONGINT;
    END;

  (* Private *)
  PROCEDURE IsSpace(ch: CHAR): BOOLEAN;
  BEGIN
    RETURN (ch = ' ') OR (ch = CHR(9)) OR
      (ch = CHR(11)) OR (ch = CHR(12)) OR
      (ch = CHR(13))
  END IsSpace;

  (* Public *)
  PROCEDURE Create*():DynamicString;
    VAR ret:DynamicString;
  BEGIN
    NEW(ret);
    NEW(ret.data,InitialSize);
    ret.length := 0;
    ret.capacity := InitialSize;
    RETURN ret
  END Create;

  PROCEDURE Clear*(ds:DynamicString);
  BEGIN
    ASSERT(ds # NIL);
    ds.data[0] := 0X;
    ds.length := 0;
    ds.capacity := 0;
  END Clear;
  
  PROCEDURE Resize(VAR ds:DynamicString;minsize:LONGINT);
    VAR ret:DynamicString;
  BEGIN
    ASSERT(ds # NIL);
    IF minsize >= ds.capacity THEN
      REPEAT ds.capacity := ds.capacity * 2 UNTIL ds.capacity > minsize;
      NEW(ret);
      NEW(ret.data,ds.capacity);
      ret.length := ds.length;
      ret.capacity := ds.capacity;
      COPY(ds.data^,ret.data^);
      ds := ret;
    END;
  END Resize;

  PROCEDURE Put*(VAR ds:DynamicString;ch:CHAR;at:LONGINT);
  BEGIN
    ASSERT(ds # NIL);
    IF at+1 >= ds.capacity THEN Resize(ds,at+1) END;
    ds.data[at] := ch;
  END Put;

  PROCEDURE Get*(VAR ds:DynamicString;at:LONGINT):CHAR;
  BEGIN
    ASSERT(ds # NIL);
    IF at+1 > ds.length THEN RETURN 0X ELSE RETURN ds.data[at] END
  END Get;

  PROCEDURE AppendCharacter*(VAR ds:DynamicString;ch:CHAR);
  BEGIN
    ASSERT(ds # NIL);
    IF ch # 0X THEN
      IF ds.length+2 >= ds.length THEN Resize(ds,ds.length+2) END;
      ds.data[ds.length] := ch;
      ds.data[ds.length+1] := 0X;
      INC(ds.length);
    END;
  END AppendCharacter;

  PROCEDURE Append*(VAR ds:DynamicString;s:ARRAY OF CHAR);
    VAR slength:LONGINT;
  BEGIN
    ASSERT(ds # NIL);
    slength := Strings.Length(s);
    IF ds.length+slength+1 >= ds.length THEN Resize(ds,ds.length+slength+1) END;
    Strings.Append(s,ds.data^);
    ds.length := ds.length + slength
  END Append;

  PROCEDURE Extract*(VAR ds:DynamicString;offset,len:LONGINT):String;
    VAR
      s:String;
      i:LONGINT;
  BEGIN
    ASSERT(ds # NIL);
    IF offset < ds.length THEN
      IF offset+len > ds.length THEN len := ds.length - offset END;
      NEW(s,len+1);
      FOR i := 0 TO len-1 DO
	s[i] := ds.data[i+offset]
      END;
      s[len] := 0X;
    ELSE
      NEW(s,1); s[0] := 0X;
    END;
    RETURN s
  END Extract; 

  PROCEDURE Length*(VAR ds:DynamicString):LONGINT;
  BEGIN
    ASSERT(ds # NIL);
    RETURN ds.length
  END Length;

  PROCEDURE ToArrOfChar*(VAR ds:DynamicString):String;
    VAR s:String;
  BEGIN
    ASSERT(ds # NIL);
    NEW(s,ds.length+1);
    COPY(ds.data^,s^);
    RETURN s
  END ToArrOfChar;

  PROCEDURE FromArrOfChar*(VAR s:String):DynamicString;
    VAR
      ret:DynamicString;
      len:LONGINT;
  BEGIN
    ASSERT(s # NIL);
    len := Strings.Length(s^);
    NEW(ret);
    ret.length := len;
    ret.capacity := len;
    NEW(ret.data,ret.capacity);
    COPY(s^,ret.data^);
    RETURN ret
  END FromArrOfChar;

  PROCEDURE Compare*(VAR ds1,ds2:DynamicString):LONGINT;
    VAR
      i,j:LONGINT;
      c1,c2:CHAR;
  BEGIN
    ASSERT((ds1 # NIL) & (ds2 # NIL));
    i := 0;
    j := 0;
    REPEAT
      c1 := ds1.data[i];
      c2 := ds2.data[i];
      IF c1 = 0X THEN RETURN ORD(c1) - ORD(c2) END;
      INC(i);
      INC(j);
    UNTIL c1 # c2;
    RETURN ORD(c1) - ORD(c2)
  END Compare;

  PROCEDURE ToUpper*(VAR ds:DynamicString);
    VAR i:LONGINT;
  BEGIN
    ASSERT((ds # NIL) & (ds.length > 0));
    FOR i := 0 TO ds.length-1 DO
      IF (ds.data[i] >= "a") & (ds.data[i] <= "z") THEN
	ds.data[i] := CHR(ORD(ds.data[i]) - ORD("a") + ORD("A"));
      END;
    END;
  END ToUpper;

  PROCEDURE ToLower*(VAR ds:DynamicString);
    VAR i:LONGINT;
  BEGIN
    ASSERT((ds # NIL) & (ds.length > 0));
    FOR i := 0 TO ds.length-1 DO
      IF (ds.data[i] >= "A") & (ds.data[i] <= "Z") THEN
	ds.data[i] := CHR(ORD(ds.data[i]) + ORD("a") - ORD("A"));
      END;
    END;
  END ToLower;

  PROCEDURE TrimLeft*(VAR ds:DynamicString);
    VAR i,j:LONGINT;
  BEGIN
    i := 0; j := 0;
    WHILE (IsSpace(ds.data[i])) & (i < Length(ds)) DO INC(i) END;
    WHILE ds.data[i] # 0X DO
      ds.data[j] := ds.data[i];
      INC(i);
      INC(j);
    END;
    ds.data[j] := 0X;
  END TrimLeft;

  PROCEDURE TrimRight*(VAR ds:DynamicString);
    VAR i,len:LONGINT;
  BEGIN
    len := Length(ds);
    i := len;
    WHILE (IsSpace(ds.data[i])) & (i >= 0) DO DEC(i) END;
    WHILE i <= len DO ds.data[i] := 0X; INC(i) END;
  END TrimRight;

  PROCEDURE Trim*(VAR ds:DynamicString);
  BEGIN
    TrimLeft(ds);
    TrimRight(ds)
  END Trim;
  
  PROCEDURE Reverse*(VAR ds:DynamicString);
    VAR
      i,length,middle:LONGINT;
      temp:CHAR;
  BEGIN
    length := Length(ds);
    middle := length DIV 2;
    FOR i := 0 TO middle-1 DO
      temp := ds.data[i];
      ds.data[i] := ds.data[length-i-1];
      ds.data[length-i-1] := temp;
    END;
  END Reverse;

  PROCEDURE EndsWith*(VAR ds:DynamicString;str:ARRAY OF CHAR):BOOLEAN;
    VAR
      i,dslen,strlen:LONGINT;
  BEGIN
    dslen := Length(ds);
    strlen := Strings.Length(str);
    IF strlen > dslen THEN RETURN FALSE END;
    FOR i := 0 TO strlen DO
      IF ds.data[dslen-i] # str[strlen-i] THEN RETURN FALSE END
    END;
    RETURN TRUE
  END EndsWith;

  PROCEDURE Equals*(VAR ds1,ds2:DynamicString):BOOLEAN;
    VAR
      i,ds1len,ds2len:LONGINT;
  BEGIN
    ds1len := Length(ds1);
    ds2len := Length(ds2);
    FOR i := 0 TO Length(ds1) DO
      IF ds1.data[i] # ds2.data[i] THEN RETURN FALSE END
    END;
    RETURN TRUE
  END Equals;
  
BEGIN
END DynamicString.

