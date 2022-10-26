with Ada.Text_IO; use Ada.Text_IO;

procedure Ch2 is
  function Total_Zero(Xin,Yin:Integer) return Integer is
    Result:Integer := 0;
    X:Integer := Xin;
    Y:Integer := Yin;
  begin
    while(X > 0 and Y > 0) loop
      if(X >= Y) then
        X := X - Y;
      else
        Y := Y - X;
      end if;
      Result := Result + 1;
    end loop;
    return Result;
  end Total_Zero;
begin
  Put_Line(Integer'Image(Total_Zero(5,4)));
  Put_Line(Integer'Image(Total_Zero(4,6)));
  Put_Line(Integer'Image(Total_Zero(2,5)));
  Put_Line(Integer'Image(Total_Zero(3,1)));
  Put_Line(Integer'Image(Total_Zero(7,4)));
end Ch2;

