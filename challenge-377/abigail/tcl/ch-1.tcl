#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    if {[regexp {(.).?\1|(.)(.).*\3\2} $line]} {
        puts "true"
    } else {
        puts "false"
    }
}
