' Challenge 093
'
' TASK #1 › Max Points
' Submitted by: Mohammad S Anwar
' You are given set of co-ordinates @N.
'
' Write a script to count maximum points on a straight line when given co-ordinates plotted on 2-d plane.
'
' Example 1:
' |
' |     x
' |   x
' | x
' + _ _ _ _
'
' Input: (1,1), (2,2), (3,3)
' Output: 3
' Example 2:
' |
' |
' | x       x
' |   x
' | x   x
' + _ _ _ _ _
'
' Input: (1,1), (2,2), (3,1), (1,3), (5,3)
' Output: 3

Type PointType
    x as Integer
    y as Integer
End Type

Dim Shared points() as PointType

' read points from command line
Sub read_points()
    Dim i as Integer
    i = 0
    Do While Command(1+2*i) <> ""
        Redim Preserve points(i) as PointType
        points(i).x = Val(Command(1+2*i))
        points(i).y = Val(Command(1+2*i+1))
        i = i+1
    Loop
End Sub

' check if three points are in a line
Function three_in_line(i as PointType, j as PointType, k as PointType) as Boolean
    Dim dxc as Integer, dyc as Integer, dxl as Integer, dyl as Integer, cross as Integer
    dxc = k.x - i.x: dyc = k.y - i.y
    dxl = j.x - i.x: dyl = j.y - i.y
    cross = dxc * dyl - dyc * dxl
    three_in_line = (cross = 0)
End Function

' count total points through given two points
Function count_in_line(i as PointType, j as PointType) as Integer
    Dim npoints as Integer
    Dim k as Integer

    npoints = 0
    For k=LBound(points) to UBound(points)
        If three_in_line(i, j, points(k)) Then
            npoints = npoints+1
        End If
    Next k
    count_in_line = npoints
End Function

' count max points in line
Function count_max_in_line() as Integer
    Dim max_npoints as Integer, npoints as Integer
    Dim i as Integer, j as Integer

    max_npoints = 0
    For i=LBound(points) to UBound(points)-1
        For j=i+1 to UBound(points)
            npoints = count_in_line(points(i), points(j))
            If npoints > max_npoints Then
                max_npoints = npoints
            End If
        Next j
    Next i
    count_max_in_line = max_npoints
End Function


' main
read_points
print count_max_in_line()
