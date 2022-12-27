#!/bin/sh

perl -wl -e 'my @o = sort { ($a == 0) ? 1 : ( ($b == 0) ? -1 : 0 )  } @ARGV; print "@o"' $@
