' Challenge 120
'
' TASK #2 - Clock Angle
' Submitted by: Mohammad S Anwar
' You are given time $T in the format hh:mm.
'
' Write a script to find the smaller angle formed by the hands of an analog
' clock at a given time.
'
' HINT: A analog clock is divided up into 12 sectors. One sector represents 30
' degree (360/12 = 30).
'
' Example
' Input: $T = '03:10'
' Output: 35 degree
'
' The distance between the 2 and the 3 on the clock is 30 degree.
' For the 10 minutes i.e. 1/6 of an hour that have passed.
' The hour hand has also moved 1/6 of the distance between the 3 and the 4,
' which adds 5 degree (1/6 of 30).
' The total measure of the angle is 35 degree.
'
' Input: $T = '04:00'
' Output: 120 degree

sub parseTime(hhmm as String, byref hh as Integer, byref mm as Integer)
    dim p as Integer

    p = InStr(hhmm, ":")
    hh = val(left(hhmm, p-1))
    mm = val(mid(hhmm, p+1))
end sub

sub clockAngles(hh as Integer, mm as Integer, _
                byref hh_angle as Integer, byref mm_angle as Integer)
    mm_angle = mm*360\60
    hh_angle = (hh mod 12)*360\12 + mm_angle*(360\12)\360
end sub

function clockAngle(hh as Integer, mm as Integer) as Integer
    dim hh_angle as Integer, mm_angle as Integer, angle as Integer

    clockAngles hh, mm, hh_angle, mm_angle
    angle = abs(hh_angle - mm_angle)
    if angle > 180 then angle = 360 - angle
    clockAngle = angle
end function

dim hh as Integer, mm as Integer, angle as Integer

parseTime Command(1), hh, mm
angle = clockAngle(hh, mm)
print angle
