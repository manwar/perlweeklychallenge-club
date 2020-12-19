#!/usr/bin/env perl

use strict;
use warnings;

=head1 NAME

PWC 091 Challenge 1

=head1 SYNOPSIS

  $ ch-1.pl 1122234
  21321314

=head1 DESCRIPTION

Given a positive number $N, this script counts the instances of numbers from 0-9
and displays the number of occurances.

=head1 SOLUTION

This solution first sanitizes the input to ensure that we are dealing with only
positive numbers, so any number greater than 0.  After that, it loops through
the digits 0 to 9, and for each digit will fetch out an array of digits if they
exist using a regex.  Finally, simply print the count and the digit if any
happen to be found.

=head1 AUTHORS

Joel Crosswhite E<lt>joel.crosswhite@ix.netcom.comE<gt>

=cut

my $input = $ARGV[0];
if (!defined($input) || $input !~ m/^[1-9]\d*$/) {
    print "Usage: ch-1.pl <positive integer>\n";
    exit 1;
}

foreach my $digit (0..9) {
    my @numbers = ($input =~ /$digit/g);
    print scalar(@numbers) . $digit if scalar(@numbers) > 0;
}

exit 0;