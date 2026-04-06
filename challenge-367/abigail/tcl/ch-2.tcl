#!/opt/homebrew/bin/tclsh

proc tcmp {t1 t2} {
    if {[expr [lindex $t1 0] < [lindex $t2 0]]} {return -1}
    if {[expr [lindex $t1 0] > [lindex $t2 0]]} {return  1}
    if {[expr [lindex $t1 1] < [lindex $t2 1]]} {return -1}
    if {[expr [lindex $t1 1] > [lindex $t2 1]]} {return  1}
    return 0
}

while {[gets stdin line] >= 0} {
    set b1 [split [lindex $line 0] ":"]
    set e1 [split [lindex $line 1] ":"]
    set b2 [split [lindex $line 2] ":"]
    set e2 [split [lindex $line 3] ":"]

    set straddle1 [expr [tcmp $b1 $e1] > 0]
    set straddle2 [expr [tcmp $b2 $e2] > 0]

    if {$straddle1 && $straddle2} {
        puts "true"
        continue
    }

    if ($straddle1) {
        if {[expr [tcmp $b1 $e2] >= 0] && [expr [tcmp $e1 $b2] <= 0]} {
            puts "false"
        } \
        else {
            puts "true"
        }
        continue
    }

    if ($straddle2) {
        if {[expr [tcmp $b2 $e1] >= 0] && [expr [tcmp $e2 $b1] <= 0]} {
            puts "false"
        } \
        else {
            puts "true"
        }
        continue
    } 

    if {[expr [tcmp $e2 $b1] <= 0] || [expr [tcmp $b2 $e1] >= 0]} {
        puts "false"
    } \
    else {
        puts "true"
    }
}
