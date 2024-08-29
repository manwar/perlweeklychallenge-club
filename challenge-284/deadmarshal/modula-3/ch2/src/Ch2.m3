MODULE Ch2 EXPORTS Main;

IMPORT SIO,Integer,IntIntTbl,IntArraySort;

VAR
  A1:ARRAY[0..10] OF INTEGER := ARRAY OF INTEGER{2,3,9,3,1,4,6,7,2,8,5};
  A2:ARRAY[0..5] OF INTEGER := ARRAY OF INTEGER{2,1,4,3,5,6};
  A3:ARRAY[0..8] OF INTEGER := ARRAY OF INTEGER{3,3,4,6,2,4,2,1,3};
  A4:ARRAY[0..2] OF INTEGER := ARRAY OF INTEGER{1,3,2};
  A5:ARRAY[0..8] OF INTEGER := ARRAY OF INTEGER{3,0,5,0,2,1,4,1,1};
  A6:ARRAY[0..3] OF INTEGER := ARRAY OF INTEGER{1,0,3,2};

PROCEDURE RelativeSort(VAR A,B:ARRAY OF INTEGER) =
  VAR
    Ranks,Ranked:IntIntTbl.Default := NEW(IntIntTbl.Default).init(NUMBER(A));
    V:INTEGER;
  PROCEDURE Compare(A,B:INTEGER):[-1..1] =
  VAR Res,V1,V2:INTEGER;
  BEGIN
    EVAL Ranked.get(A,V1);
    EVAL Ranked.get(B,V2);
    Res := Integer.Compare(V2,V1);
    IF Res # 0 THEN RETURN Res END;
    EVAL Ranks.get(A,V1);
    EVAL Ranks.get(B,V2);    
    Res := Integer.Compare(V1,V2);
    IF Res # 0 THEN RETURN Res END;
    RETURN Integer.Compare(A,B)
  END Compare;
  BEGIN
    FOR I := FIRST(B) TO LAST(B) DO
      IF NOT Ranks.get(B[I],V) THEN EVAL Ranks.put(B[I],I) END
    END;
    FOR I := FIRST(A) TO LAST(A) DO
      IF Ranks.get(A[I],V) THEN EVAL Ranked.put(A[I],1)
      ELSE EVAL Ranked.put(A[I],0)
      END
    END;
    IntArraySort.Sort(A,Compare)
  END RelativeSort;

PROCEDURE PrintArray(VAR A:ARRAY OF INTEGER) =
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      SIO.PutInt(A[I]);
      SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintArray;
  
BEGIN  
  RelativeSort(A1,A2);
  RelativeSort(A3,A4);
  RelativeSort(A5,A6);
  PrintArray(A1);
  PrintArray(A3);
  PrintArray(A5)
END Ch2.

