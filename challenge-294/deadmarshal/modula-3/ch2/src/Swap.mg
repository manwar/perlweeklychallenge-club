GENERIC MODULE Swap(Elem);

PROCEDURE Swap(VAR A,B:Elem.T) =
  VAR Temp:Elem.T := A;
  BEGIN
    A := B;
    B := Temp
  END Swap;
  
BEGIN
  
END Swap.

