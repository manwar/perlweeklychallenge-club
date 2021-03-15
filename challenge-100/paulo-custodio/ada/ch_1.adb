-- Challenge 100
--
-- TASK #1 > Fun Time
-- Submitted by: Mohammad S Anwar
-- You are given a time (12 hour / 24 hour).
--
-- Write a script to convert the given time from 12 hour format to 24 hour format
-- and vice versa.
--
-- Ideally we expect a one-liner.
--
-- Example 1:
-- Input: 05:15 pm or 05:15pm
-- Output: 17:15
-- Example 2:
-- Input: 19:15
-- Output: 07:15 pm or 07:15pm

with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Command_Line;
with Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO; use Ada.Text_IO; use Ada;

procedure ch_1 is
    -- command line arguments
    package CL renames Ada.Command_Line;

    -- strings
    package SB is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
    use SB;

    -- integer formatting
    package Integer_IO is new Ada.Text_IO.Integer_IO (Integer);

    -- parse time
    procedure parse_time(text : String;
                        hour, minute : out Integer;
                        am, pm: out Boolean) is
        p_colon, p_am, p_pm, p_end_minute : Integer := 0;
    begin
        -- find bounds
        p_colon := Index(text, ":");

        p_am := Index(To_Lower(text), "am");
        if p_am > p_colon then
            am := True;
        else
            am := False;
        end if;

        p_pm := Index(To_Lower(text), "pm");
        if p_pm > p_colon then
            pm := True;
        else
            pm := False;
        end if;

        p_end_minute := text'Last;
        if p_am > p_colon then
            p_end_minute := Integer'Min(p_end_minute, p_am-1);
        elsif p_pm > p_colon then
            p_end_minute := Integer'Min(p_end_minute, p_pm-1);
        end if;

        -- parse time
        hour := Integer'Value(text(text'First .. p_colon-1));
        minute := Integer'Value(text(p_colon+1 .. p_end_minute));

        -- convert 12->24
        if am then
            if hour = 12 then
                hour := 0;
            end if;
        elsif pm then
            if hour /= 12 then
                hour := hour + 12;
            end if;
        end if;
    end parse_time;

    -- output hh:mm
    procedure print_hhmm(hour, minute: Integer) is
    begin
        if hour < 10 then
            Integer_IO.Put(0, 0);
        end if;
        Integer_IO.Put(hour, 0);
        Text_IO.Put(":");
        if minute < 10 then
            Integer_IO.Put(0, 0);
        end if;
        Integer_IO.Put(minute, 0);
    end print_hhmm;

    -- convert time
    procedure convert_time(text: String) is
        hour, minute : Integer := 0;
        am, pm : Boolean := False;
        ampm : String := "am";
    begin
        parse_time(text, hour, minute, am, pm);

        if not (am or pm) then
            -- convert 24->12
            if hour = 0 then
                hour := 12;
            elsif hour = 12 then
                ampm := "pm";
            elsif hour > 12 then
                hour := hour - 12;
                ampm := "pm";
            end if;

            print_hhmm(hour, minute);
            Text_IO.Put(ampm);
        else
            print_hhmm(hour, minute);
        end if;
    end convert_time;

begin
    convert_time(CL.Argument(1));
end ch_1;
