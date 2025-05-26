MODULE Ch2 EXPORTS Main;

IMPORT SIO;

VAR
  A1 := ARRAY[0..2],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{3,50},
  ARRAY[0..1] OF INTEGER{7,10},
  ARRAY[0..1] OF INTEGER{12,25}};

  A2 := ARRAY[0..2],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{1,0},
  ARRAY[0..1] OF INTEGER{4,25},
  ARRAY[0..1] OF INTEGER{5,50}};

  A3 := ARRAY[0..0],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{2,50}};
      
PROCEDURE TaxAmount(READONLY Income:INTEGER;
                    VAR A:ARRAY OF ARRAY OF INTEGER):LONGREAL =
  VAR Res,Prev:INTEGER;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      INC(Res,MAX(0,MIN(Income,A[I][0]) - Prev) * A[I][1]);
      Prev := A[I][0]
    END;
    RETURN FLOAT(Res,LONGREAL) / 100.0D0;
  END TaxAmount;
  
BEGIN
  SIO.PutLongReal(TaxAmount(10,A1)); SIO.Nl();
  SIO.PutLongReal(TaxAmount(2,A2)); SIO.Nl();
  SIO.PutLongReal(TaxAmount(0,A3)); SIO.Nl()
END Ch2.

