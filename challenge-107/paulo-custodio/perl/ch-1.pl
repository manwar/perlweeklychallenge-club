#!/usr/bin/env perl

# Challenge 107
#
# TASK #1 - Self-descriptive Numbers
# Submitted by: Mohammad S Anwar
# Write a script to display the first three self-descriptive numbers. As per
# wikipedia, the definition of Self-descriptive Number is
#
# In mathematics, a self-descriptive number is an integer m that in a given
# base b is b digits long in which each digit d at position n (the most
# significant digit being at position 0 and the least significant at position
# b−1) counts how many instances of digit n are in m.
#
# For example:
#
#  1210 is a four-digit self-descriptive number:
#
#     position 0 has value 1 i.e. there is only one 0 in the number
#     position 1 has value 2 i.e. there are two 1 in the number
#     position 2 has value 1 i.e. there is only one 2 in the number
#     position 3 has value 0 i.e. there is no 3 in the number
# Output
#     1210, 2020, 21200

use Modern::Perl;

print_self_descriptive(3);

sub print_self_descriptive {
    my($num) = @_;
    my $found = 0;
    for (my $base = 4; 1; $base++) {
        my @n = (1, (0) x ($base-1));
        while (@n == $base) {
            if (is_self_descriptive(@n)) {
                print ", " if $found > 0;
                print join '', @n;
                $found++;
                if ($found >= $num) {
                    print "\n";
                    return;
                }
            }
            increment(\@n, $base);
        }
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
