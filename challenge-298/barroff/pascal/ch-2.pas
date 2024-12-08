
Program Ch2;

{$mode objfpc}{$H+}{$J-}

Uses Math;

Type 
  TInterval = array[0 .. 1] Of Integer;
  TIntervalArr = array Of TInterval;
  TIntArr = array Of Integer;

Function rightInterval(Const Intervals: TIntervalArr): TIntArr;

Var rp, i, j: Integer;
Begin
  result := Default(TIntArr);
  setlength(result, length(Intervals));
  For i := low(Intervals) To high(Intervals) Do
    Begin
      rp := -1;
      For j := low(Intervals) To high(Intervals) Do
        Begin
          If Intervals[j][0] = Intervals[i][1] Then
            Begin
              rp := j;
              break;
            End;
          If Intervals[j][0] > Intervals[i][1] Then
            Begin
              If rp = -1 Then
                Begin
                  rp := j;
                End
              Else
                Begin
                  If Intervals[j][0] < Intervals[rp][1] Then
                    Begin
                      rp := j;
                    End;
                End;
            End;
        End;
      result[i] := rp;
    End;
End;

Procedure printArray(Const A: TIntArr);

Var 
  i: Integer;
Begin
  write('Array: (');
  For i In A Do
    Begin
      write(' ', i);
    End;
  writeln(' )');
End;

Var 
  a: TInterval = (3, 4);
  b: TInterval = (2, 3);
  c: TInterval = (1, 2);
  d: TInterval = (1, 4);
  e: TInterval = (2, 2);
  res: TIntArr;

Begin
  res := rightInterval([a, b, c]);
  printArray(res);
  res := rightInterval([d, b, a]);
  printArray(res);
  res := rightInterval([c]);
  printArray(res);
  res := rightInterval([d, e, a]);
  printArray(res);
End.
