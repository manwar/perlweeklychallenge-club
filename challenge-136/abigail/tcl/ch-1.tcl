#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl < input-file
#

#
# Find the GCD, using Stein's algorithm
#    (https://en.wikipedia.org/wiki/Binary_GCD_algorithm)
#
proc gcd {u v} {
    set u_odd [expr $u % 2]
    set v_odd [expr $v % 2]
    if {$u == $v || $v == 0} {return $u}
    if {            $u == 0} {return $v}
    if {$u_odd == 0 && $v_odd == 0} {
        return [expr [gcd [expr $u >> 1] [expr $v >> 1]] << 1]
    }
    if {$u_odd == 0 && $v_odd >  0} {
        return [gcd [expr $u >> 1] $v]
    }
    if {$u_odd >  0 && $v_odd == 0} {
        return [gcd $u [expr $v >> 1]]
    }
    if {$u > $v} {
        return [gcd [expr $u - $v] $v]
    }
    return [gcd [expr $v - $u] $u]
}

#  
# Return 1 if number is a power of n, that is, number == n ^ p   
# for some non-negative integer p. Return 0 otherwise.   
#
proc is_power_of_n {number n} {
    if {$number <  1} {return 0}
    if {$number == 1} {return 1}
    if {$number % $n} {return 0}
                       return [is_power_of_n [expr $number / $n] $n]
}

proc is_power_of_2 {number} {
    return [is_power_of_n $number 2]
}

while {[gets stdin line] >= 0} {
    lassign [split $line " "] m n
    if {[expr $m % 2] == 1 || [expr $n % 2] == 1} {
        puts 0
    } else {
        set r [gcd $m $n]
        if {$r > 1 && [is_power_of_2 $r]} {
            puts 1
        } else {
            puts 0
        }
    }
}
