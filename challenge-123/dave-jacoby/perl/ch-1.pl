#!/usr/bin/env perl

use feature qw{say state signatures};
use strict;
use warnings;
use utf8;
no warnings qw{ experimental };

use Carp;
use Getopt::Long;

my $n = 8;

GetOptions( 'n=i' => \$n, );
carp 'Bad Input' unless $n > 0;

my $u = get_ugly($n);
say "Input:  \$n = $n";
say "Output: $u";

sub get_ugly ( $n ) {
    return 1 if $n == 1;
    my $c = 1;
    my $u = 0;
    while (1) {
        $u++;
        my $f = 0;
        $f = 1 if $u % 2 == 0;
        $f = 1 if $u % 3 == 0;
        $f = 1 if $u % 5 == 0;
        $c++      if $f;
        return $u if $n == $c;
    }
}
