MODULE Ch1;

  IMPORT Out;

  VAR
    A1,A2,A3,A4:ARRAY 5 OF LONGINT;
    
  PROCEDURE Init;
  BEGIN
    A1[0] := 1; A1[1] := 2; A1[2] := 5; A1[3] := 3; A1[4] := 4;
    A2[0] := 4; A2[1] := 6; A2[2] := 7; A2[3] := 8; A2[4] := 9;
    A3[0] := 1; A3[1] := 3; A3[2] := 5; A3[3] := 7; A3[4] := 9;
    A4[0] := 0; A4[1] := 2; A4[2] := 4; A4[3] := 6; A4[4] := 8;
  END Init;

  PROCEDURE DisjointSets(VAR arr1,arr2:ARRAY OF LONGINT):LONGINT;
    VAR
      i:LONGINT;
      hash:ARRAY 10 OF LONGINT;
  BEGIN
    FOR i := 0 TO LEN(hash)-1 DO hash[i] := 0 END;
    FOR i := 0 TO LEN(arr1)-1 DO
      INC(hash[arr1[i] MOD 10]);
      INC(hash[arr2[i] MOD 10]);
    END;
    FOR i := 0 TO LEN(arr1)-1 DO IF hash[i] > 1 THEN RETURN 0 END END;
    RETURN 1
  END DisjointSets;

BEGIN
  Init;
  Out.Int(DisjointSets(A1,A2),0); Out.Ln;
  Out.Int(DisjointSets(A3,A4),0); Out.Ln  
END Ch1.

