#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-154
#

#
# Run as: awk -f ch-1.awk < input-file
#

BEGIN {
    p ["PERL"] = 1; p ["PELR"] = 1; p ["PREL"] = 1
    p ["PRLE"] = 1; p ["PLER"] = 1; p ["PLRE"] = 1
    p ["EPRL"] = 1; p ["EPLR"] = 1; p ["ERPL"] = 1
    p ["ERLP"] = 1; p ["ELPR"] = 1; p ["ELRP"] = 1
    p ["REPL"] = 1; p ["RELP"] = 1; p ["RPEL"] = 1
    p ["RPLE"] = 1; p ["RLEP"] = 1; p ["RLPE"] = 1
    p ["LERP"] = 1; p ["LEPR"] = 1; p ["LREP"] = 1
    p ["LRPE"] = 1; p ["LPER"] = 1; p ["LPRE"] = 1
}

{
    delete p [$1]
}

END {
    for (x in p) {
        print x
    }
}
