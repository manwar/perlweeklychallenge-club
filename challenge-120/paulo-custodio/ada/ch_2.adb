-- Challenge 120
--
-- TASK #2 › Clock Angle
-- Submitted by: Mohammad S Anwar
-- You are given time $T in the format hh:mm.
--
-- Write a script to find the smaller angle formed by the hands of an analog
-- clock at a given time.
--
-- HINT: A analog clock is divided up into 12 sectors. One sector represents 30
-- degree (360/12 = 30).
--
-- Example
-- Input: $T = '03:10'
-- Output: 35 degree
--
-- The distance between the 2 and the 3 on the clock is 30 degree.
-- For the 10 minutes i.e. 1/6 of an hour that have passed.
-- The hour hand has also moved 1/6 of the distance between the 3 and the 4,
-- which adds 5 degree (1/6 of 30).
-- The total measure of the angle is 35 degree.
--
-- Input: $T = '04:00'
-- Output: 120 degree

with Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

procedure ch_2 is
    package CL renames Ada.Command_Line;

    procedure parseTime(hhmm: String; hh, mm: out Integer) is
        pos: Integer;
    begin
        pos := Index(hhmm, ":");
        hh := Integer'Value(hhmm(hhmm'First..pos-1));
        mm := Integer'Value(hhmm(pos+1..hhmm'Last));
    end parseTime;

    procedure clockAngles(hh, mm: Integer; hh_angle, mm_angle: out Integer) is
    begin
        mm_angle := mm*360/60;
        hh_angle := (hh mod 12)*360/12 + mm_angle*(360/12)/360;
    end clockAngles;

    function clockAngle(hh, mm: Integer) return Integer is
        hh_angle, mm_angle, angle: Integer;
    begin
        clockAngles(hh, mm, hh_angle, mm_angle);
        angle := abs(hh_angle - mm_angle);
        if angle > 180 then
            angle := 360 - angle;
        end if;
        return angle;
    end clockAngle;

    hhmm : String := CL.Argument(1);
    hh, mm, angle: Integer;
begin
    parseTime(hhmm, hh, mm);
    angle := clockAngle(hh, mm);
    Put_Line(Integer'Image(angle));
end ch_2;
