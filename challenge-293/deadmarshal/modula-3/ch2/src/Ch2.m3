MODULE Ch2 EXPORTS Main;

IMPORT SIO;

TYPE
  Point = RECORD
    X,Y:INTEGER := 0;
  END;

VAR
  A1 := ARRAY[0..2] OF Point{Point{1,1},Point{2,3},Point{3,2}};
  A2 := ARRAY[0..2] OF Point{Point{1,1},Point{2,2},Point{3,3}};
  A3 := ARRAY[0..2] OF Point{Point{1,1},Point{1,2},Point{2,3}};
  A4 := ARRAY[0..2] OF Point{Point{1,1},Point{1,2},Point{1,3}};
  A5 := ARRAY[0..2] OF Point{Point{1,1},Point{2,1},Point{3,1}};
  A6 := ARRAY[0..2] OF Point{Point{0,0},Point{2,3},Point{4,5}};
      
PROCEDURE Boomerang(VAR A:ARRAY OF Point):BOOLEAN =
  BEGIN
    RETURN (A[1].Y - A[0].Y) * (A[2].X - A[1].X) #
           (A[2].Y - A[1].Y) * (A[1].X - A[0].X)
  END Boomerang;
  
BEGIN
  SIO.PutBool(Boomerang(A1)); SIO.Nl();
  SIO.PutBool(Boomerang(A2)); SIO.Nl();
  SIO.PutBool(Boomerang(A3)); SIO.Nl();
  SIO.PutBool(Boomerang(A4)); SIO.Nl();
  SIO.PutBool(Boomerang(A5)); SIO.Nl();
  SIO.PutBool(Boomerang(A6)); SIO.Nl()
END Ch2.

