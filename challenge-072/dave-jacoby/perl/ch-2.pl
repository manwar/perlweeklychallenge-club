#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Carp;
use Getopt::Long;

my $f = $0; # this program
my $a = 1;  
my $b = 4;
GetOptions(
    'f=s' => \$f,
    'a=i' => \$a,
    'b=i' => \$b,
);

show_lines( $a, $b, $f );

sub show_lines ( $a, $b, $f ) {
    my $c = 0;
    if ( open my $fh, '<', $f ) {
        my @array = <$fh>;
        for my $i (@array) {
            $c++;
            next if $c > $b;
            next if $c < $a;
            print $i ;
        }
    }
}
