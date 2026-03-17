#!/usr/bin/env perl

# Perl Weekly Challenge 303 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-303/

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";

say calc_earned(@ARGV);

sub calc_earned {
    my(@nums) = @_;
    my $max_earned = 0;

    my $calc_earned;
    $calc_earned = sub {
        my($earned, @pending) = @_;
        if (@pending == 0) {
            $max_earned = $earned if $max_earned < $earned;
        }
        else {
            for my $i (0 .. $#pending) {
                my $item = $pending[$i];
                my @new_pending = @pending;

                # remove current item;
                splice(@new_pending, $i, 1);

                # remove all equal to above and below
                @new_pending = grep {$_ != $item+1 && $_ != $item-1} @new_pending;

                $calc_earned->($earned+$item, @new_pending);
            }
        }
    };

    $calc_earned->(0, @nums);
    return $max_earned;
}
