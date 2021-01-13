#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';
use Data::Dumper;

my $m = $ARGV[0] || 3;
my %qp;

for my $d (1..$m) {
    my @arr = map [(-1) x $m], 1 .. $m;

    for my $r (0..$m-1) {
        for my $c (0..$m-1) {
            if ($arr[$r][$c] == -1) {
                $qp{"[$r:$c]"} ? 
                    ($arr[$r][$c] = 0) : 
                    remove_captures(\@arr,$r,$c) 
            }
        }
    }

    for my $r (0..$m-1) {
        say "@{$arr[$r]}";
    }
    print "\n"
}

sub remove_captures {
    my ($arr,$r,$c) = @_;

    $qp{"[$r:$c]"} = $arr->[$r][$c] = 1;

    my $s = $#{$arr};

    for my $x ($r+1..$s) {
        $arr->[$x][$c] = 0;
    }

    for my $y ($c+1..$s) {
        $arr->[$r][$y] = 0;
    }

    for my $o (0..$m-1) {
        if ( $c+$o <= $s && $r+$o <= $s && $arr->[$r+$o][$c+$o] == -1) {
            $arr->[$r+$o][$c+$o] = 0
        }

        if ($c+$o <= $s  && $r-$o >= 0  && $arr->[$r-$o][$c+$o] == -1) {
            $arr->[$r-$o][$c+$o] = 0
        }

        if ($r+$o <= $s  && $c-$o >= 0  && $arr->[$r+$o][$c-$o] == -1) {
            $arr->[$r+$o][$c-$o] = 0
        }

        if ($r-$o >= 0 && $c-$o >= 0 && $arr->[$r-$o][$c-$o] == -1) {
            $arr->[$r-$o][$c-$o] = 0
        }
    }


}