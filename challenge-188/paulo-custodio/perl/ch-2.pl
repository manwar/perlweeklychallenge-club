#!/usr/bin/env perl

# Perl Weekly Challenge 188 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-188/

use Modern::Perl;

sub total_zero {
    my($x,$y)=@_;
    die if $x<=0 || $y<=0;
    my $count=0;
    while ($x>0 && $y>0) {
        if ($x==$y) {       $x=$y=0;    }
        elsif ($x>$y) {     $x-=$y;     }
        else {              $y-=$x;     }
        $count++;
    }
    return $count;
}

say total_zero(@ARGV);
