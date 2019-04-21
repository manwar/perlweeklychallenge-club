#!/usr/bin/env perl

use strict;
use warnings;

# usage:
# cat words | perl -p ./ch-2.pl foobar
#
# you can figure out whats actually going on this way:
# perl -MO=Deparse -p ./ch-2.pl

our $letters;

BEGIN {
    $letters = join '', @ARGV;
    @ARGV    = ();
}

my $t = $letters;

while ( /\w/g ) {
    $t =~ s/$&//i or $_ = '';
}
