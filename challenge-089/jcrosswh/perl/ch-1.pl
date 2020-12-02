#!/usr/bin/env perl

use strict;
use warnings;

=head1 NAME

PWC 089 Challenge 1

=head1 SYNOPSIS

  $ ch-1.pl 3
  3
  
  $ ch-1.pl 4
  7

=head1 DESCRIPTION

Given a positive integer, this script will sum the
L<GCD|https://en.wikipedia.org/wiki/Greatest_common_divisor> of all possible
unique pairs between 1 and the inputed positive integer.

=head1 AUTHORS

Joel Crosswhite E<lt>joel.crosswhite@ix.netcom.comE<gt>

=cut

my $input = $ARGV[0];
if (!defined($input) || $input !~ m/^[1-9]\d*$/) {
    print "Usage: ch-1.pl <positive integer>\n";
    exit 1;
}

my $retval = 0;
for (my $i = 1; $i < $input; $i++) {
    for (my $k = $i + 1; $k <= $input; $k++) {
        $retval += gcd($i, $k);
    }
}

print $retval . "\n";
exit 0;

sub gcd {
    my ($first, $second, $d) = @_;
    $d = 0 if !defined($d);
    
    if ($first == $second) {
        return $first * 2 ** $d;
    } elsif ($first % 2 == 0 && $second % 2 == 0) {
        return gcd($first / 2, $second / 2, $d + 1);
    } elsif ($first % 2 == 0) {
        return gcd($first / 2, $second, $d);
    } elsif ($second % 2 ==0) {
        return gcd($first, $second / 2, $d);
    } else {
        my $c = abs($first - $second);
        my $new_second = $first < $second ? $first : $second;
        return gcd($c / 2, $new_second, $d);
    }
}# gcd
