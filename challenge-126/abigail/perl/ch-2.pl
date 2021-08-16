#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

#
# Read the input board
#
my @input = map {[/\S/g]} <>;

my @output;
my $X =   @input;
my $Y = @{$input [0]};

#
# Loop over each cell of the board. If the cell contains a mine,
# copy the mine. Else, iterate over the 8 neighbours, skipping 
# neighbours outside of the board, and count the mines. Put the
# count in the output structure.
#
for my $x (0 .. ($X - 1)) {
    foreach my $y (0 .. ($Y - 1)) {
        if ($input  [$x] [$y] eq 'x') { # Mine
            $output [$x] [$y] =  'x';
            next;
        }
        my $mines = 0;
        for my $dx (-1 .. 1) {
            next if $x + $dx < 0 || $x + $dx >= $X;     # Above or below board
            for my $dy (-1 .. 1) {
                next if $y + $dy < 0 || $y + $dy >= $Y; # Right or left of board
                next unless $dx || $dy;                 # Skip self
                $mines ++ if $input [$x + $dx] [$y + $dy] eq 'x';
            }
        }
        $output [$x] [$y] = $mines;
    }
}

#
# Print it
#
say "@$_" for @output;


__END__
