' Challenge 101
'
' TASK #1 › Pack a Spiral
' Submitted by: Stuart Little
'
' You are given an array @A of items (integers say, but they can be anything).
'
' Your task is to pack that array into an MxN matrix spirally counterclockwise,
' as tightly as possible.
'
' ‘Tightly’ means the absolute value |M-N| of the difference has to be as small
' as possible.

const max_numbers as integer = 100

dim shared number_list(max_numbers) as integer
dim shared number_rect(max_numbers,max_numbers) as integer
dim shared num_width as integer, rect_width as integer, rect_height as integer
dim shared num_numbers as integer

' collect from command line
sub collect_numbers()
    dim i as integer
    i = 1
    do while command(i)<>""
        number_list(i) = val(command(i))
        if len(command(i))>num_width then
            num_width = len(command(i))
        end if
        num_numbers = i
        i = i + 1
    loop
end sub

' get smallest rectangle
sub smallest_rect(byref rect_width as integer, byref rect_height as integer)
    dim i as integer
    rect_width = 1
    rect_height = num_numbers
    for i=1 to num_numbers
        if (num_numbers mod i) = 0 then
            rect_width = i
            rect_height = int(num_numbers / i)
            if rect_width >= rect_height then exit for
        end if
    next
end sub

' pack the numbers in a spiral
sub pack_numbers(rect_width as integer, rect_height as Integer)
    dim row as integer, col as integer, idx as integer

    ' fill matrix with -1 - to mark places that are free
    for row=1 to rect_height
        for col=1 to rect_width
            number_rect(row, col) = -1
        next
    next

    idx = 1
    row = rect_height
    col = 1
    do while idx <= num_numbers
        ' go East
        do while col <= rect_width
            if number_rect(row, col) >= 0 then exit do
            number_rect(row, col) = number_list(idx)
            idx = idx + 1
            col = col + 1
        loop
        col = col - 1
        row = row - 1

        ' go North
        do while row >= 1
            if number_rect(row, col) >= 0 then exit do
            number_rect(row, col) = number_list(idx)
            idx = idx + 1
            row = row - 1
        loop
        row = row + 1
        col = col - 1

        ' go West
        do while col >= 1
            if number_rect(row, col) >= 0 then exit do
            number_rect(row, col) = number_list(idx)
            idx = idx + 1
            col = col - 1
        loop
        col = col + 1
        row = row + 1

        ' go South
        do while row <= rect_height
            if number_rect(row, col) >= 0 then exit do
            number_rect(row, col) = number_list(idx)
            idx = idx + 1
            row = row + 1
        loop
        row = row - 1
        col = col + 1
    loop
end sub

' print the rectangle
sub print_rect(rect_width as integer, rect_height as Integer)
    dim row as integer, col as integer
    for row=1 to rect_height
        for col=1 to rect_width
            print right(space(10) & str(number_rect(row, col)), num_width+1);
        next
        print
    next
end sub

' main
collect_numbers
smallest_rect rect_width, rect_height
pack_numbers rect_width, rect_height
print_rect rect_width, rect_height
