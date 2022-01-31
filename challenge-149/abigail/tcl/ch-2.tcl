#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
#

#
# Run as: tclsh ch-2.tcl < input-file
#

set A287298 list

lset A287298  0                          ""
lset A287298  1                          ""
lset A287298  2                         "1"
lset A287298  3                         "1"
lset A287298  4                      "3201"
lset A287298  5                      "4301"
lset A287298  6                    "452013"
lset A287298  7                   "6250341"
lset A287298  8                  "47302651"
lset A287298  9                 "823146570"
lset A287298 10                "9814072356"
lset A287298 11               "A8701245369"
lset A287298 12              "B8750A649321"
lset A287298 13              "CBA504216873"
lset A287298 14            "DC71B30685A924"
lset A287298 15           "EDAC93B24658701"
lset A287298 16          "FED5B39A42706C81"
lset A287298 17          "GFED5A31C6B79802"
lset A287298 18        "HGF80ADC53712EB649"
lset A287298 19       "IHGFD3408C6E715A2B9"
lset A287298 20      "JIHG03DAC457BFE96281"
lset A287298 21                          ""
lset A287298 22    "LKJIG5D14B9032FHAC867E"
lset A287298 23   "MLKJEFG5IC1D9H8042AB376"
lset A287298 24  "NMLKJ2BD0639GFE7C8IH5A41"
lset A287298 25 "ONMLKD8CJE2H47F6395I0B1AG"

while {[gets stdin n] >= 0} {
    if {[string length [lindex $A287298 $n]] > 0} {
        puts [lindex $A287298 $n]
    } else {
        puts "Too hard to calculate"
    }
}
