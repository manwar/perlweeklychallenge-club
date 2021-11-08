(*
Challenge 119

TASK #2 - Sequence without 1-on-1
Submitted by: Cheok-Yin Fung
Write a script to generate sequence starting at 1. Consider the increasing
sequence of integers which contain only 1's, 2's and 3's, and do not have any
doublets of 1's like below. Please accept a positive integer $N and print the
$Nth term in the generated sequence.

1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, ...

Example
Input: $N = 5
Output: 13

Input: $N = 10
Output: 32

Input: $N = 60
Output: 2223
*)

program ch2(input, output);
uses sysutils;
function nextSeq(n: Integer): Integer;
    function numOk(n: Integer): Boolean;
        var
            lastDigit, digit: Integer;
        begin
            if n <= 0 then
                numOk := False
            else begin
                numOk := True;
                digit := 0;
                while n > 0 do begin
                    lastDigit := digit;
                    digit := n mod 10;
                    n := n div 10;
                    if (digit < 1) or (digit > 3)
                    or ((digit = 1) and (lastDigit = 1)) then
                        numOk := False;
                end;
            end;
        end;
    begin
        repeat
            n := n + 1;
        until numOk(n);
        nextSeq := n;
    end;
var
    num, i, n: Integer;
begin
    num := StrToInt(paramStr(1));
    n := 0;
    for i := 1 to num do
        n := nextSeq(n);
    WriteLn(n);
end.
