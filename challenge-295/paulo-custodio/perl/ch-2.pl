#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(min);

@ARGV or die "usage: $0 nums\n";
say min_jumps(@ARGV);

sub min_jumps {
    my(@jumps) = @_;

    my $min_jumps = 1e10;
    my $found_solution = 0;

    my $try_jump;
    $try_jump = sub {
        my($prev_jumps, $pos) = @_;
        if ($pos == $#jumps) {
            # found the target
            $found_solution = 1;
            $min_jumps = min($min_jumps, $prev_jumps);
        }
        elsif ($pos > $#jumps) {
            # missed the target
        }
        elsif ($prev_jumps > $min_jumps) {
            # path too long
        }
        else {
            # try each jump
            for my $jump (1 .. $jumps[$pos]) {
                $try_jump->($prev_jumps+1, $pos+$jump);
            }
        }
    };

    $try_jump->(0, 0);

    return $found_solution ? $min_jumps : -1;
}
