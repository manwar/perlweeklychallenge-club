#!/usr/bin/env perl
#===============================================================================
#
#        FILE: 6602.pl
#
#        USAGE: ./6602.pl NNN
#
#  DESCRIPTION: Express the provided number as positive integer powers
#
# REQUIREMENTS: perl v5.14.0
#        NOTES: Argument must be a natural number or script will die
#      AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
#
#===============================================================================

use strict;
use warnings;
use 5.014;

my $n;
die "Argument must be a natural number\n" unless
    $n = shift (@ARGV) and
    $n =~ /^\d+$/a;

my $ans = power ($n);
print "$ans\n";
exit;

sub power {
    my $n = shift;
    return 0 if $n < 4;

    my $root = 2;
    my @ans;

    while (1) {
        # Pesky FP
        my $e = int sprintf "%.3f", ($n ** (1 / $root));
        last if $e < 2;
        if ($e ** $root == $n) {
            push @ans, "$e^$root";
        }
        $root++;
    }
    return @ans ? join ' ', @ans : 0;
}

__END__
$ ./6602.pl 27
3^3
$ ./6602.pl 625
25^2 5^4
$ ./6602.pl 65536
256^2 16^4 4^8 2^16
$ ./6602.pl 4.2
Argument must be a natural number
$ ./6602.pl -3
Argument must be a natural number
$ ./6602.pl 1
0
