#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl
#

array set tail {0 789 1 798 2 879 3 897 4 978}

for {set i 0} {$i < [array size tail]} {incr i} {
    puts "1023456$tail($i)"
}
