#!/usr/bin/env perl
#
=head1 Task 1: Self Spammer

Submitted by: David Ferrone

Write a program which outputs one word of its own script / source code at
random. A word is anything between whitespace, including symbols.

=head2 Example 1

If the source code contains a line such as: 'open my $fh, "<", "ch-1.pl" or
die;' then the program would output each of the words { open, my, $fh,, "<",,
"ch-1.pl", or, die; } (along with other words in the source) with some positive
probability.

=head2 Example 2

Technically 'print(" hello ");' is *not* an example program, because it does
not assign positive probability to the other two words in the script.  It will
never display print(" or ");

=head2 Example 3

An empty script is one trivial solution, and here is another:
echo "42" > ch-1.pl && perl -p -e '' ch-1.pl

=cut

use strict;
use warnings;
use Data::Dumper;

sub self_spammer
{
    my $filename = shift;

    open my $fh, '<', $filename or die "Error opening $filename: $!\n";
    my $string = do { local $/; <$fh> };
    close $fh;

    $string =~ s/\R//g;
    my @words = split /\s+/, $string;

    my $i = int(rand(@words));
    return $words[$i];
}

print self_spammer($0), "\n";

exit 0;
