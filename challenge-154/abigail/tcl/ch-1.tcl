#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-154
#

#
# Run as: tclsh ch-1.tcl < input-file
#

set p [dict create PERL 1 PELR 1 PREL 1 PRLE 1 PLER 1 PLRE 1 \
                   EPRL 1 EPLR 1 ERPL 1 ERLP 1 ELPR 1 ELRP 1 \
                   REPL 1 RELP 1 RPEL 1 RPLE 1 RLEP 1 RLPE 1 \
                   LERP 1 LEPR 1 LREP 1 LRPE 1 LPER 1 LPRE 1]

while {[gets stdin word] >= 0} {
    dict unset p $word
}

puts [dict keys $p]
