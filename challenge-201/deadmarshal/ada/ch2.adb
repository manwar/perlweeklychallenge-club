with Ada.Text_IO; use Ada.Text_IO;

procedure Ch2 is
  Count:Integer := 0;
  type TArr is array(0..4) of integer;
  Arr:TArr;

  procedure Find_Combinations(Arr:in out TArr;Index,Num,Reduced_Num:Integer) is
    Prev:Integer;
  begin
    if Reduced_Num < 0 then return; end if;
    if Reduced_Num = 0 then Count := Count + 1; return; end if;
    if Index = 0 then Prev := 1; else Prev := Arr(Index-1); end if;
    for I in Prev..Num loop
      Arr(Index) := I;
      Find_Combinations(Arr,Index+1,Num,Reduced_Num-I);
    end loop;
  end Find_Combinations;
begin
  Find_Combinations(Arr,0,5,5);
  Put_Line(Integer'Image(Count));
end Ch2;

