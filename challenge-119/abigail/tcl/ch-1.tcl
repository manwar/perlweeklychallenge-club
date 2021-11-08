#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl < input-file
#

while {[gets stdin num] >= 0} {
    puts [expr ($num & ~0xFF)      \
             | ($num &  0x0F) << 4 \
             | ($num &  0xF0) >> 4]
}
