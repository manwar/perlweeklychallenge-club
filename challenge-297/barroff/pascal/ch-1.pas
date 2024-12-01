
Program Ch1;

{$mode objfpc}

Uses Math;

Type
  TBin = 0 .. 1;

  generic Function sumBin<T>(Const A: Array Of T): Integer;

Var i: Integer;
Begin
  result := 0;
  For i := low(A) To high(A) Do
    Begin
      result := result + Integer(A[i]);
    End;
End;

Function contiguousArray(A: Array Of TBin): Integer;

Var
  i, j, k, s: Integer;
Begin
  s := specialize sumBin<TBin>(A);
  s := Min(s, length(A) - s);
  For i := s Downto 1 Do
    Begin
      j := 2 * i - 1;
      For k := low(A) To high(A) - j Do
        Begin
          If specialize sumBin<TBin>(A[k..k+j]) = i Then
            exit(2 * i);
        End;
    End;
  contiguousArray := 0;
End;

Begin
  Writeln(contiguousArray([ 1, 0, 1, 0, 1 ]));
  Writeln(contiguousArray([ 0, 0, 1, 0, 1 ]));
  Writeln(contiguousArray([ 1, 0, 0, 0, 1 ]));
  Writeln(contiguousArray([ 1, 0 ]));
  Writeln(contiguousArray([ 0, 1, 0 ]));
  Writeln(contiguousArray([ 0, 0, 0, 0 ]));
  Writeln(contiguousArray([ 0, 1, 0, 0, 1, 0 ]));
End.
