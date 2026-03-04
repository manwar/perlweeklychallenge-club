#!/usr/bin/env tclsh
#
# Task 2: Subnet Sheriff
# 
# Submitted by: Peter Campbell Smith
# 
# You are given an IPv4 address and an IPv4 network (in CIDR format).  Write a
# script to determine whether both are valid and the address falls within the
# network. For more information see the Wikipedia article.
# 
# Example 1
# 
#     Input: $ip_addr = "192.168.1.45"
#            $domain  = "192.168.1.0/24"
#     Output: true
# 
# Example 2
# 
#     Input: $ip_addr = "10.0.0.256"
#            $domain  = "10.0.0.0/24"
#     Output: false
# 
# Example 3
# 
#     Input: $ip_addr = "172.16.8.9"
#            $domain  = "172.16.8.9/32"
#     Output: true
# 
# Example 4
# 
#     Input: $ip_addr = "172.16.4.5"
#            $domain  = "172.16.0.0/14"
#     Output: true
# 
# Example 5
# 
#     Input: $ip_addr = "192.0.2.0"
#            $domain  = "192.0.2.0/25"
#     Output: true
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{"192.168.1.45" "192.168.1.0/24"}  true "Example 1"}
    {{  "10.0.0.256"    "10.0.0.0/24"} false "Example 2"}
    {{  "172.16.8.9"  "172.16.8.9/32"}  true "Example 3"}
    {{  "172.16.4.5"  "172.16.0.0/14"}  true "Example 4"}
    {{   "192.0.2.0"   "192.0.2.0/25"}  true "Example 5"}
    {{     "192.0.2"   "192.0.2.0/25"} false "Example 6"}
    {{   "192.0.2.0"   "192.0.2.0+25"} false "Example 7"}
    {{  "10.0.0.255"  "10.256.0.0/24"} false "Example 8"}
}

proc subnet_sheriff {param} {
    set ip_addr  [lindex $param 0]
    set net_mask [lindex $param 1]

    if {![regexp {^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$} $ip_addr]} {
        return false
    }
    if {![regexp {^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(?:\/([1-2]?[0-9]|3[0-2]))$} $net_mask]} {
        return false
    }

    set net_base [lindex [split $net_mask "/"] 0]
    set mask     [lindex [split $net_mask "/"] 1]

    binary scan [binary format c4 [split $ip_addr "."]] I ip
    binary scan [binary format c4 [split $net_base "."]] I base

    set net_mask_int [expr (2 ** $mask - 1) << (32 - $mask)]

    if {[expr ($ip & $net_mask_int) == ($base & $net_mask_int)] == 1} {
        return true
    } else {
        return false
    }
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        subnet_sheriff [lindex $case 0]
    } [lindex $case 1]
}

exit 0

