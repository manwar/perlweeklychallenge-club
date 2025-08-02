#!/usr/bin/env perl

# Challenge 176
#
# Task 2: Reversible Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to find out all Reversible Numbers below 100.
#
#     A number is said to be a reversible if sum of the number and its reverse
#     had only odd digits.
#
# For example,
#
# 36 is reversible number as 36 + 63 = 99 i.e. all digits are odd.
# 17 is not reversible as 17 + 71 = 88, none of the digits are odd.
#
# Output
#
# 10, 12, 14, 16, 18, 21, 23, 25, 27,
# 30, 32, 34, 36, 41, 43, 45, 50, 52,
# 54, 61, 63, 70, 72, 81, 90

use Modern::Perl;

sub is_reversible {
    my($n) = @_;
    my $rev = join '', reverse split //, $n;
    return ($n+$rev) =~ /^[13579]+$/;
}

sub reversibles_up_to {
    my($N) = @_;
    my $n = 1;
    my @result;
    while ($n < $N) {
        push @result, $n if is_reversible($n);
        $n++;
    }
    return @result;
}

@ARGV==1 or die "usage: ch-2.pl N\n";
my $N = shift;
say join ", ", reversibles_up_to($N);
