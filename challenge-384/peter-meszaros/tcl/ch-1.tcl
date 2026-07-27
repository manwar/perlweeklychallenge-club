#!/usr/bin/env tclsh
#

package require Tcl 8.6
package require tcltest

set cases {
}

proc {} {

}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        [lindex $case 0]
    } [lindex $case 1]
}

exit 0
