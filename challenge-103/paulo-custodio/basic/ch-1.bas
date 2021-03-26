' Challenge 103
'
' TASK #1 › Chinese Zodiac
' Submitted by: Mohammad S Anwar
' You are given a year $year.
'
' Write a script to determine the Chinese Zodiac for the given year $year.
' Please check out wikipage for more information about it.
'
' The animal cycle: Rat, Ox, Tiger, Rabbit, Dragon, Snake, Horse, Goat, Monkey,
' Rooster, Dog, Pig.
' The element cycle: Wood, Fire, Earth, Metal, Water.
'
' Example 1:
'     Input: 2017
'     Output: Fire Rooster
' Example 2:
'     Input: 1938
'     Output: Earth Tiger

dim shared animals(11) as string
dim shared elements(9) as string

data "Rat","Ox","Tiger","Rabbit","Dragon","Snake","Horse","Goat","Monkey","Rooster","Dog","Pig"
data "Wood","Wood","Fire","Fire","Earth","Earth","Metal","Metal","Water","Water"

dim i as integer, s as string
for i=0 to 11: read s: animals(i)=s:next
for i=0 to 9: read s: elements(i)=s:next

dim year as integer
year=val(command(1))-1924
print elements(year mod 10);" ";animals(year mod 12)
