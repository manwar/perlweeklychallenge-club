program AbundantOddNumbers;

{$mode objfpc}{$H+}{$J-}

function SumDivisors(const vNumber: Integer): Integer;
var
	vDivisor: Integer;
begin
	result := 0;

	for vDivisor := 1 to vNumber div 2 do begin
		if vNumber mod vDivisor = 0 then
			result += vDivisor;
	end;
end;

function GetNextAbundantOddNumber(const vCurrent: Integer): Integer;
begin
	result := vCurrent;
	while (result mod 2 = 0) or (SumDivisors(result) <= result) do
		result += 1;
end;

var
	vNext: Integer;
	vInd: Integer;
begin
	vNext := 0;
	for vInd := 1 to 20 do begin
		vNext := GetNextAbundantOddNumber(vNext + 1);
		writeln(vNext);
	end;

end.

