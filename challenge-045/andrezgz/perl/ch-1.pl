#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-045/
# Task #1
# Square Secret Code
# The square secret code mechanism first removes any space from the original message.
# Then it lays down the message in a row of 8 columns.
# The coded message is then obtained by reading down the columns going left to right.
#
# For example, the message is "The quick brown fox jumps over the lazy dog".
#
# Then the message would be laid out as below:
#
# thequick
# brownfox
# jumpsove
# rthelazy
# dog
# The code message would be as below:
#
# tbjrd hruto eomhg qwpe unsl ifoa covz kxey
#
# Write a script that accepts a message from command line
#  and prints the equivalent coded message.

use strict;
use warnings;

# only lower-case letters from arguments form a string
my $msg = join '',
          map {my $w = lc $_; $w =~ s/[[:^lower:]]//g; $w }
          @ARGV or die "USAGE: $0 <message>";

my %cols;
# each letter is appended to the corresponding column
$cols{$_ % 8} .= substr $msg, $_, 1 for (0 .. (length $msg) -1 );

# coded message is formed by printing each column string in order
print join ' ', map { $cols{$_} } sort keys %cols;

__END__

./ch-1.pl The quick brown fox jumps over the lazy dog
tbjrd hruto eomhg qwpe unsl ifoa covz kxey
