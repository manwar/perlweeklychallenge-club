' Challenge 206
'
' Task 1: Shortest Time
' Submitted by: Mohammad S Anwar
'
' You are given a list of time points, at least 2, in the 24-hour clock format HH:MM.
'
' Write a script to find out the shortest time in minutes between any two time points.
' Example 1
'
' Input: @time = ("00:00", "23:55", "20:00")
' Output: 5
'
' Since the difference between "00:00" and "23:55" is the shortest (5 minutes).
'
' Example 2
'
' Input: @array = ("01:01", "00:50", "00:57")
' Output: 4
'
' Example 3
'
' Input: @array = ("10:10", "09:30", "09:00", "09:55")
' Output: 15

dim mins() as integer

' parse hours:minutes, return minutes
function parse_minutes(s as string) as integer
    dim i as integer, hours as integer, minutes as integer

    'parse hours
    i=1
    do while i<=len(s) and mid(s,i,1)>="0" and mid(s,i,1)<="9"
        i=i+1
    loop
    hours=val(left(s,i))
    if mid(s,i,1)=":" then i=i+1
    s=mid(s,i)

    'parse minutes
    do while i<=len(s) and mid(s,i,1)>="0" and mid(s,i,1)<="9"
        i=i+1
    loop
    minutes=val(left(s,i))
    parse_minutes=60*hours+minutes
end function

' collect arguments
sub collect_args(mins() as integer)
    dim i as integer

    i=0
    do while command(i+1)<>""
        redim preserve mins(i) as integer
        mins(i)=parse_minutes(command(i+1))
        i=i+1
    loop
end sub

' sort array
sub sort(mins() as integer)
    dim i as integer, j as integer, n as integer

    for i=lbound(mins) to ubound(mins)-1
        for j=i+1 to ubound(mins)
            if mins(i)>mins(j) then
                n=mins(i): mins(i)=mins(j): mins(j)=n
            end if
        next
    next
end sub

' prepare data for check - sort and add first+24hours to end
sub setup_data(mins() as integer)
    dim i as integer

    collect_args mins()
    sort mins()
    i=ubound(mins)
    redim preserve mins(i+1) as integer
    mins(i+1)=mins(0)+24*60
end sub


' get minimum interval
function get_min_interval(mins() as integer) as integer
    dim i as integer, min as integer

    min=mins(ubound(mins))-mins(0)
    for i=0 to ubound(mins)-1
        if mins(i+1)-mins(i)<min then
            min=mins(i+1)-mins(i)
        end if
    next
    get_min_interval=min
end function

setup_data mins()
print get_min_interval(mins())
