' Challenge 100
'
' TASK #1 > Fun Time
' Submitted by: Mohammad S Anwar
' You are given a time (12 hour / 24 hour).
'
' Write a script to convert the given time from 12 hour format to 24 hour format
' and vice versa.
'
' Ideally we expect a one-liner.
'
' Example 1:
' Input: 05:15 pm or 05:15pm
' Output: 17:15
' Example 2:
' Input: 19:15
' Output: 07:15 pm or 07:15pm

function format_nn(n as integer) as string
    format_nn = right("00" & trim(str(n)), 2)
end function

function convert_time(text as string) as string
    dim hour as integer, minute as integer, am as boolean, pm as boolean
    dim ampm as string

    text = lcase(text)
    hour = val(text)
    minute = val(mid(text, instr(text, ":")+1))
    if instr(text, "am") > 0 then am = true
    if instr(text, "pm") > 0 then pm = true
    if am or pm then
        ' 12->24
        if pm then
            if hour < 12 then hour = hour + 12
        else
            if hour = 12 then hour = 0
        end if
        convert_time = format_nn(hour) & ":" & format_nn(minute)
    else
        ' 24->12

        ampm = "am"
        if hour = 0 then
            hour = 12
        elseif hour = 12 then
            ampm = "pm"
        elseif hour > 12 then
            hour = hour - 12
            ampm = "pm"
        end if
        convert_time = format_nn(hour) & ":" & format_nn(minute) & ampm
    end if
end function

print convert_time(command(1))
