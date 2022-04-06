#!/usr/bin/env perl

# Challenge 043
#
# TASK #2
# Self-descriptive Numbers
# Contributed by Laurent Rosenfeld
# Write a script to generate Self-descriptive Numbers in a given base.
#
# In mathematics, a self-descriptive number is an integer m that in a given base
# b is b digits long in which each digit d at position n (the most significant
# digit being at position 0 and the least significant at position b - 1) counts
# how many instances of digit n are in m.
#
# For example, if the given base is 10, then script should print 6210001000. For
# more information, please checkout wiki page.

use Modern::Perl;

my $base = shift||4;
print_self_descriptive($base);

sub print_self_descriptive {
    my($base) = @_;
    my @n = (1, (0) x ($base-1));
    while (@n == $base) {
        if (is_self_descriptive(@n)) {
            say join '', @n;
            return;
        }
        increment(\@n, $base);
    }
}

sub increment {
    my($n, $base) = @_;
    my $i = $#$n;
    while ($i >= 0) {
        $n->[$i]++;
        if ($n->[$i] < $base) {
            return;
        }
        else {
            $n->[$i] = 0;
            $i--;
        }
    }
    unshift @$n, 1;
}

sub is_self_descriptive {
    my(@n) = @_;
    for my $i (0..$#n) {
        my $count = scalar grep {$_==$i} @n;
        return if $n[$i] != $count;
    }
    return 1;
}
