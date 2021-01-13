#!/usr/bin/env perl

use strict;
use warnings;

=head1 NAME

PWC 091 Challenge 2

=head1 SYNOPSIS

  $ ch-2.pl 1,2,3
  1

  $ ch-2.pl 5,2,3
  0

=head1 DESCRIPTION

Given an array of positive numbers @N, where the value at each index determines
how far you are allowed to jump. This script will decide if you can jump,
exactly, to the last index. It will print 1 if you are able to reach the last
index or 0 if you can't.

=head1 SOLUTION

First this script will sanatize the input, making sure that only a list of
numbers separated by commas was passed in.  The script will parse and store
these numbers in an array.  Then we will "walk" the array by trying to jump
exactly to the end, and if that's not possible, try to jump forward, and if we
can't do that then inform the user that it's not possible.

=head1 AUTHORS

Joel Crosswhite E<lt>joel.crosswhite@ix.netcom.comE<gt>

=cut

my $input = $ARGV[0];
if (!defined($input) || $input !~ m/^([1-9],)*[1-9]$/) {
    print "Usage: ch-2.pl <positive integer>,<positive integer>,...\n";
    exit 1;
}

my @N = split(/,/, $input);
my $length = scalar(@N);
my $index = 0;

while (1) {
    
    my $current_number = $N[$index];
    
    if ($current_number == $length - $index) {
        print 1 . "\n";
        exit 0;
    } elsif ($current_number < $length - $index) {
        $index += $N[$index];
    } else {
        print 0 . "\n";
        exit 0;
    }
}
