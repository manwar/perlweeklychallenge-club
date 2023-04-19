#!/usr/bin/perl -s

use v5.16;
use warnings;
use List::MoreUtils 'zip6';

die <<EOS unless @ARGV;
usage: $0 [LIST...]

LIST...
    one or more lists of "items".  Items are separated by comma
    and / or blanks.

EOS


# Split arguments at comma/space and combine the items from each list.
# Need to circumvent zip6's prototype.
say "@$_" for &zip6(map [split /[ ,]\s*/, $_], @ARGV);
