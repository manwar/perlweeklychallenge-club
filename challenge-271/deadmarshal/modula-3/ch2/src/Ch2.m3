MODULE Ch2 EXPORTS Main;

IMPORT SIO,Fmt,Text,Integer,IntSorting;

VAR
  A1:ARRAY[0..8] OF INTEGER := ARRAY[0..8] OF INTEGER{0,1,2,3,4,5,6,7,8};
  A2:ARRAY[0..4] OF INTEGER := ARRAY[0..4] OF INTEGER{1024,512,256,128,64};

PROCEDURE PopCount(READONLY N:INTEGER):INTEGER =
  VAR
    Temp:TEXT := Fmt.Int(N,2);
    Count:INTEGER := 0;
  BEGIN
    FOR I := 0 TO Text.Length(Temp)-1 DO
      IF Text.GetChar(Temp,I) = '1' THEN INC(Count) END
    END;
    RETURN Count
  END PopCount;
  
PROCEDURE Compare(READONLY a,b:INTEGER):[-1..1] =
  VAR
    Pa,Pb:INTEGER;
  BEGIN
    Pa := PopCount(a);
    Pb := PopCount(b);
    IF Pa = Pb THEN RETURN Integer.Compare(a,b) END;
    RETURN Integer.Compare(Pa,Pb);
  END Compare;
    
PROCEDURE SortByBits(VAR A:ARRAY OF INTEGER) =
  BEGIN
    IntSorting.QuickSort(A,FIRST(A),LAST(A),Compare)
  END SortByBits;
  
PROCEDURE PrintArray(VAR A:ARRAY OF INTEGER) =
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      SIO.PutInt(A[I]);
      SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintArray;
  
BEGIN
  SortByBits(A1);
  SortByBits(A2);
  PrintArray(A1);
  PrintArray(A2)
END Ch2.

