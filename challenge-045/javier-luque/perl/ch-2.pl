#!/usr/bin/perl
# test: perl ch-2.pl | diff - ch-2.pl
use strict;
use warnings;
use feature qw /say/;

open(my $fh, '<:encoding(UTF-8)', $0) || die "$@";
while (my $line = <$fh>) {
    print $line;
};
