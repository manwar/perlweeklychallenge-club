#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub search {
    my ($board) = @_;

    my $rowlast = scalar @{$board} - 1;
    my $collast = scalar @{$board->[0]} - 1;

    for my $row (0 .. $rowlast)  {
        for my $col (0 .. $collast) {
            if ($board->[$row]->[$col] == -1) {
                for my $y ($row - 1 .. $row + 1) {
                    for my $x ($col - 1 .. $col + 1) {
                        if ($y < 0 || $y > $rowlast || $x < 0 || $x > $collast) {
                            next;
                        }
                        if ($board->[$y]->[$x] != -1) {
                            $board->[$y]->[$x]++;
                        }
                    }
                }
            }
        }
    }
    return $board;
}

sub output {
    my ($board) = @_;

    for my $row (0 .. scalar @{$board} - 1)  {
        for my $col (0 .. scalar @{$board->[$row]} - 1) {
            print $board->[$row]->[$col] == -1 ? 'x' : $board->[$row]->[$col],
                ' ';
        }
        print "\n";
    }
}

my $filename = shift // die "Need filename\n";

my @board;

open my $fn, '<',  $filename or die "$OS_ERROR\n";
while (my $line = <$fn>) {
    push @board, [ map { $_ eq '*' ? 0 : -1; } split q{ }, $line ];
}
close $fn;

output(search(\@board));
