#!perl

# Copyright © 2024 PerlMonk Athanasius

use v5.32;
use autodie;
use List::Util 'shuffle';

$| = 1;
my %dict;

open my $fh, '<', $0;

while (my $line = <$fh>)
{
    ++$dict{$_} for grep { length } split /\s+/, $line;
}

close $fh;
say +(shuffle keys %dict)[0];
