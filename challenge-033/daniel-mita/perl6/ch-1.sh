#!/bin/sh
perl6 -e '.say for @*ARGS ?? slurp.lc.comb(/<[a..z]>/).Bag.sort !! "give at least 1 filename"' $@
