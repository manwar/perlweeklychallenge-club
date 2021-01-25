#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Getopt::Long;

my $n = 3;
my $s = 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG';

GetOptions(
    'number=i' => \$n,
    'string=s' => \$s,
);

caesar_cipher( $s, $n );

sub caesar_cipher ( $s, $n ) {
    my @alpha = 'A' .. 'Z';
    my @bet   = @alpha;
    for ( 1 .. $n ) {
        unshift @bet, pop @bet;
    }

    my $alpha  = join '', @alpha;
    my $bet    = join '', @bet;
    my %cipher = map { $alpha[$_] => $bet[$_] } 0 .. $#alpha;

    $s = uc $s;

    my $t = join '', map { $cipher{$_} ? $cipher{$_} : $_ } split //, $s;

    say <<"END";

    INPUT:
        \$S = "$s", \$N = $n
    OUTPUT:
        "$t"
    
    Plain:  $alpha
    cipher: $bet

END

}
