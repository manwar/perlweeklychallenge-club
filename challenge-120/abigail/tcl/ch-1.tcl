#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl < input-file
#

while {[gets stdin num] >= 0} {
    puts [expr ($num & 0x55) << 1 \
             | ($num & 0xAA) >> 1]
}
