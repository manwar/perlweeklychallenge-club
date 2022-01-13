#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl < input-file
#

while {[gets stdin line] >= 0} {
    set palindromes [dict create]
    for {set i 0} {$i < [string length $line]} {incr i} {
        for {set j $i} {$j < [string length $line]} {incr j} {
            set str [string range $line $i $j]
            if {$str == [string reverse $str]} {
                dict set palindromes $str 1
            }
        }
    }
    puts [dict keys $palindromes]
}
