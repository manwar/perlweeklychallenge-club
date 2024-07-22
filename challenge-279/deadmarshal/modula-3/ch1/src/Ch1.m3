MODULE Ch1 EXPORTS Main;

IMPORT SIO,Integer,Text;
IMPORT CharIntPair,CharIntPairArraySort;

VAR
  L1:ARRAY[0..3] OF CHAR := ARRAY OF CHAR{'R','E','P','L'};
  W1:ARRAY[0..3] OF CARDINAL := ARRAY OF CARDINAL{3,2,1,4};
  L2:ARRAY[0..3] OF CHAR := ARRAY OF CHAR{'A','U','R','K'};
  W2:ARRAY[0..3] OF CARDINAL := ARRAY OF CARDINAL{2,4,1,3};
  L3:ARRAY[0..5] OF CHAR := ARRAY OF CHAR{'O','H','Y','N','P','T'};
  W3:ARRAY[0..5] OF CARDINAL := ARRAY OF CARDINAL{5,4,2,6,1,3};

PROCEDURE Compare(READONLY a,b:CharIntPair.T):[-1..1] =
  BEGIN
    RETURN Integer.Compare(CharIntPair.Second(a),
                           CharIntPair.Second(b))
  END Compare;

PROCEDURE SortLetters(READONLY L:ARRAY OF CHAR;
                      READONLY W:ARRAY OF CARDINAL):TEXT =
  VAR
    A:REF ARRAY OF CharIntPair.T :=
        NEW(REF ARRAY OF CharIntPair.T,NUMBER(L));
    Sorted:REF ARRAY OF CHAR :=
        NEW(REF ARRAY OF CHAR,NUMBER(L));
  BEGIN
    FOR I := FIRST(L) TO LAST(L) DO
      A[I] := CharIntPair.Create(L[I],W[I])
    END;
    CharIntPairArraySort.Sort(A^,Compare);
    FOR I := FIRST(A^) TO LAST(A^) DO
      Sorted[I] := CharIntPair.First(A[I])
    END;
    RETURN Text.FromChars(Sorted^)
  END SortLetters;

BEGIN
  SIO.PutText(SortLetters(L1,W1)); SIO.Nl();
  SIO.PutText(SortLetters(L2,W2)); SIO.Nl();
  SIO.PutText(SortLetters(L3,W3)); SIO.Nl()
END Ch1.

