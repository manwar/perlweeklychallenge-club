(*
Challenge 120

TASK #2 - Clock Angle
Submitted by: Mohammad S Anwar
You are given time $T in the format hh:mm.

Write a script to find the smaller angle formed by the hands of an analog
clock at a given time.

HINT: A analog clock is divided up into 12 sectors. One sector represents 30
degree (360/12 = 30).

Example
Input: $T = '03:10'
Output: 35 degree

The distance between the 2 and the 3 on the clock is 30 degree.
For the 10 minutes i.e. 1/6 of an hour that have passed.
The hour hand has also moved 1/6 of the distance between the 3 and the 4,
which adds 5 degree (1/6 of 30).
The total measure of the angle is 35 degree.

Input: $T = '04:00'
Output: 120 degree
*)

program ch2(input, output);
uses sysutils, strutils;
function parseTime(hhmm: String): Integer;
    var
        p, hh, mm: Integer;
    begin
        p := PosEx(':', hhmm);
        hh := StrToInt(LeftStr(hhmm, p-1));
        mm := StrToInt(MidStr(hhmm, p+1, length(hhmm)));
        parseTime := hh*100+mm;
    end;
function clockAngle(hhmm: Integer): Integer;
    var
        hh, mm, hh_angle, mm_angle, angle: Integer;
    begin
        hh := hhmm div 100;
        mm := hhmm mod 100;
        mm_angle := mm*360 div 60;
        hh_angle := (hh mod 12)*360 div 12 + mm_angle div 12;
        angle := abs(hh_angle - mm_angle);
        if angle > 180 then angle := 360 - angle;
        clockAngle := angle;
    end;
var
    angle: Integer;
begin
    angle := clockAngle(parseTime(paramStr(1)));
    WriteLn(angle);
end.
