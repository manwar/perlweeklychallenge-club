#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given DNA sequence, GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG.
Write a script to print nucleiobase count in the given DNA sequence. Also print the complementary sequence.
=cut










my $strand_1 = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG';
my %compl = (T => 'A', A => 'T', G => 'C', C => 'G');

my %count;
my $strand_2 = join('', map { $count{$_}++; $compl{$_}} split(//, $strand_1));

print "$_ => $count{$_}$/" for sort { $a cmp $b } keys %count;

print $strand_1, $/;
print '|' x length($strand_1), $/;
print $strand_2, $/;