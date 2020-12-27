#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

sub solve;

my @lines = <>;
say $_ ? 1 : 0 for map {solve @lines [$_ - 1, $_]} grep {$_ % 2} keys @lines;
exit;

#
# Return true of $A and $B are isomorphic.
#
# What we want is to show there is a bijection f between the letters
# of $A and the letters of $B.
#
# For a bijection, we need to show that:
#     f and f^-1 (the inverse of f) are total
#     f (x) == f (y)  <=> x == y
#
# 1) we check that $A and $B have the same length, otherwise either
#    f or f^-1 isn't total.
# 2) x == y => f (x) == f (y)
# 3) |dom (f)| = |img (f)|  (Size of the domain of f is the
#                            size of the image of f)
# 
sub solve ($A, $B) {
    return 0 unless length ($A) == length ($B);      # 1)
    my @A = split // => $A;
    my @B = split // => $B;
    my %mapping;
    foreach my $i (keys @A) {
        my $A = $A [$i];
        my $B = $B [$i];
        return 0 if $B ne ($mapping {$A} //= $B);    # 2)
    }
    my %reverse = reverse %mapping;
    keys %reverse == keys %mapping;                  # 3)
}



__END__
