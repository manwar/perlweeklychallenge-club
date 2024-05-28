GENERIC INTERFACE Sorting(Elem);

TYPE
  CompareProc = PROCEDURE(READONLY a,b:Elem.T):[-1..1];
  
PROCEDURE QuickSort(VAR A:ARRAY OF Elem.T;
                    READONLY Left,Right:INTEGER;
                    Proc:CompareProc);

END Sorting.
