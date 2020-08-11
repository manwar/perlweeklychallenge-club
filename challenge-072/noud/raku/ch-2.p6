# You are given a text file name $file and range $A - $B where $A <= $B.
#
# Write a script to display lines range $A and $B in the given file.
# Example
# Input:
#
#     $ cat input.txt
#     L1
#     L2
#     L3
#     L4
#     ...
#     ...
#     ...
#     ...
#     L100
#
# $A = 4 and $B = 12
#
# Output:
#
#     L4
#     L5
#     L6
#     L7
#     L8
#     L9
#     L10
#     L11
#     L12

sub lines-range($filename, $a, $b) {
    $filename.IO.lines[($a-1)..($b-1)];
}

.say for lines-range("input.txt", 4, 12);
