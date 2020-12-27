#!/usr/bin/env perl

use strict;
use warnings;

=head1 NAME

PWC 092 Challenge 1

=head1 SYNOPSIS

  $ ch-1.pl egg add
  1

  $ ch-1.pl foo bar
  0

=head1 DESCRIPTION

Given two strings $A and $B, this script will check to see if the given strings
are isomorphic.  It will print 1 if they are otherwise 0.

=head1 SOLUTION

This solution assumes that if the number of characters in each string is equal,
then the two strings are isomorphic.  This script works by going though all
characters, assuming case sensitivity, and determining in each inputed string
the number of times that character appears.  Internally the script maintains a
hash that keys on the number of times a character appears, and that key maps to
an array that captures which characters appeared that number of times.

Once all combinations are determined, the script will go through key values 1->
the maximum number of characters found, and examining the sizes of the arrays
for both strings for the given key.  If at any time these arrays don't match in
size, then the script will print 0 and exit, otherwise we'll complete the
examination and print 1.

For example, for the given strings 'egg' and 'add', the two hashes will look
like this:

egg: (0, ["A" .. "Z", "a" .. "d", "f", "h" .. "z"], 1, ["e"], 2, ["g"])
add: (0, ["A" .. "Z", "b", "c", "e" .. "z"], 1, ["a"], 2, ["d"])

Ignoring the non-appearing characters (0), we see that the size of the '1' array
is 1 for both strings, and the size of the '2' array is 1 for both strings,
therefore, 'egg' and 'add' are isomorphic.

=head1 AUTHORS

Joel Crosswhite E<lt>joel.crosswhite@ix.netcom.comE<gt>

=cut

my $first_string = $ARGV[0];
my $second_string = $ARGV[1];
if ((!defined($first_string) || $first_string !~ m/^[a-zA-Z]*$/)
    || (!defined($second_string) || $second_string !~ m/^[a-zA-Z]*$/)) {
    print "Usage: ch-1.pl <string> <string>\n";
    exit 1;
}

my (%char_map_first_string, %char_map_second_string);
my $max_chars_found = 0;
foreach my $starting_char ('A', 'a') {

    foreach my $char ($starting_char..'z') {

        find_number_of_characters($char, $first_string,
            \%char_map_first_string, \$max_chars_found);
        find_number_of_characters($char, $second_string,
            \%char_map_second_string, \$max_chars_found);
    }
}

foreach my $key (1..$max_chars_found) {

    if (size_of_hash_array($char_map_first_string{$key})
            != size_of_hash_array($char_map_second_string{$key})) {

        print 0 . "\n";
        exit 0;
    }
}

print 1 . "\n";
exit 0;

sub find_number_of_characters {
    my ($char, $string, $char_map, $max_chars_found) = @_;

    my @chars_found = ($string =~ /$char/g);
    push(@{$char_map->{scalar(@chars_found)}}, $char);
    $$max_chars_found = (scalar(@chars_found) > $$max_chars_found)
        ? scalar(@chars_found)
        : $$max_chars_found;
}

sub size_of_hash_array {
    my ($array) = @_;

    return defined($array) ? scalar(@{$array}) : 0;
}