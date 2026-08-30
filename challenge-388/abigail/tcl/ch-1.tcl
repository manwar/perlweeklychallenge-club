#!/opt/homebrew/bin/tclsh

proc process {n u d prefix} {
    if {$d == $n} {puts -nonewline "${prefix} "}
    if {$d <  $u} {process $n $u [expr $d + 1] "${prefix}D"}
    if {$u <  $n} {process $n [expr $u + 1] $d "${prefix}U"}
}

while {[gets stdin n] >= 0} {
    process $n 0 0 {}
    puts {}
}
