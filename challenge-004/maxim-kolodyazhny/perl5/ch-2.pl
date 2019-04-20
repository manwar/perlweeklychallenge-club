#!/usr/bin/env perl

use strict;
use warnings;

# cat words | perl -p ./ch-2.pl foobar

our $letters;

BEGIN {
    $letters = join '', @ARGV;
    @ARGV    = ();
}

my $t = $letters;

while ( /\w/g ) {
    $t =~ s/$&//i or $_='';
}
