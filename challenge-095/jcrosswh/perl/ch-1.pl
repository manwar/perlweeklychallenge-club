#!/usr/bin/env perl

use strict;
use warnings;
use Palindrome;

=head1 NAME

PWC 095 Challenge 1

=head1 SYNOPSIS

  $ ch-1.pl 1991
  1

  $ ch-1.pl 1992
  `

=head1 DESCRIPTION

Given a number $N, this script will figure out if the given number is a
palindrome. It will print 1 if true, otherwise it will print `.

=head1 SOLUTION

This solution works by taking the string/number, chopping it in half using
substr, then comparing if the first half is equal to the reverse of the second
half.

=head1 AUTHORS

Joel Crosswhite E<lt>joel.crosswhite@ix.netcom.comE<gt>

=cut

my $input = $ARGV[0];
if (!defined($input) || $input !~ m/^\d+$/) {
    print "Usage: ch-1.pl #\n";
    exit 1;
}

printf("%s\n", (Palindrome->is_palindrome($input)) ? 1 : '`');

exit 0;
