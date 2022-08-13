program DammCheckDigit;
uses
  sysutils;

const damm : array[0..9,0..9] of integer =
    ( (0,3,1,7,5,9,8,6,4,2),
      (7,0,9,2,1,5,4,8,6,3),
      (4,2,0,6,8,7,1,3,5,9),
      (1,7,5,0,9,8,3,4,2,6),
      (6,1,2,3,0,4,5,9,7,8),
      (3,6,7,4,2,0,9,5,8,1),
      (5,8,6,9,7,2,0,1,3,4),
      (8,9,4,5,3,6,2,0,1,7),
      (9,4,3,8,6,1,7,2,0,5),
      (2,5,8,1,4,3,6,7,9,0) );

function is_valid(num : integer) : boolean;
var
    temp, i : integer;
    n_str : string;
begin
    n_str := inttostr(num);
    temp := 0;
    for i := 0 to length(n_str) do
    begin
        temp := damm[temp, ord(n_str[i]) - ord ('0')];
    end;
    is_valid := temp=0;
end;

var
    i : integer;
begin
    writeln('Valid numbers between 5700 and 5800 are:');
    for i := 5700 to 5800 do
    begin
        if is_valid(i) then
             write(i, ' ');
    end;
    writeln
end.

{
Valid numbers between 5700 and 5800 are:
5708 5719 5724 5735 5743 5756 5762 5770 5781 5797
}
