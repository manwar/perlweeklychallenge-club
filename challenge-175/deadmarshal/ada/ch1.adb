with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line;use Ada.Command_Line;
with GNAT.Formatted_String; use GNAT.Formatted_String;

procedure Ch1 is
  Not_Enough_Arguments:exception;
  Input:Integer;

  function Is_Leap_Year(Year:Integer) return Boolean is
  begin
    if Year mod 100 = 0 then return Year mod 400 = 0; end if;
    return Year mod 4 = 0;
  end Is_Leap_Year;

  procedure Last_Sunday(Year:Integer) is
    Week:Integer;
    Days:array(1..12) of Integer := (31,28,31,30,31,30,31,31,30,31,30,31);
  begin
    if Is_Leap_Year(Year) then Days(2) := 29; end if;
    Week := Year * 365 + 96 * (Year - 1) / 400 + 4;
    for Month in Days'Range loop
      Week := (Week + Days(Month)) mod 7;
      Put_Line(-(+"%d-%02d-%d" & Year & Month & (Days(Month) - Week)));
    end loop;
  end Last_Sunday;
  
begin
  if Argument_Count < 1 then
    raise Not_Enough_Arguments;
  end if; 
  Input := Integer'Value(Argument(1));
  Last_Sunday(Input);
end Ch1;  

