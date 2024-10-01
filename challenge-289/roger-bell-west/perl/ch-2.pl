#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use List::Util qw(shuffle);

sub jumble($a) {
    return join('', shuffle(split('', $a)));
}

while (<>) {
    chomp;
    my $line = $_;
    $line =~ s/([A-Za-z])([A-Za-z][A-Za-z]+)([A-Za-z])/$1.jumble($2).$3/eg;
    print "$line\n";
}
