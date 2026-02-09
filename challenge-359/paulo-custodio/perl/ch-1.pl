#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(sum);

@ARGV==1 or die "usage:$0 n\n";
my($persistence, $root) = digital_root($ARGV[0]);
say "Persistence  = $persistence";
say "Digital Root = $root";

sub digital_root {
    my($n) = @_;
    my $persistence = 0;
    while ($n > 9) {
        $n = sum(split //, $n);
        $persistence++;
    }
    return ($persistence, $n);
}
