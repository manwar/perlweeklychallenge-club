#!/usr/bin/perl
use v5.38;
use builtin qw/ true false /;
no warnings 'experimental::builtin';

sub traverse($grid, $string, $visited, $row, $col) {
    state @directions = ([-1, 0], [0,  1], [1,  0], [0, -1]);

    unless (scalar @{$string}) {
        return true;
    }

    $visited->{"$row;$col"} = true;
    my @newstring = @{$string};
    my $current = shift @newstring;

    for my $dir (@directions) {
        my $newRow = $row + $dir->[0];
        my $newCol = $col + $dir->[1];

        if ($newRow >= 0 && $newRow < scalar @{$grid} &&
            $newCol >= 0 && $newCol <  scalar $grid->[0] &&
            !$visited->{"$newRow;$newCol"} &&
            defined $grid->[$newRow]->[$newCol] &&
            $grid->[$newRow]->[$newCol] eq $current
        ) {
            return traverse($grid, \@newstring, $visited, $newRow, $newCol);
        }
    }

    return false;
}

my $str = shift;
my @chars = @ARGV;
my @string = split //, $str;
my @grid;

for my $row (@chars) {
    push @grid, [split //, $row];
}

my $found = false;
my $current = shift @string;

for my $row (0 .. scalar @grid - 1) {
    for my $col (0 .. scalar @{$grid[$row]} - 1) {
        if ($grid[$row]->[$col] eq $current) {
            my %visited;
            if (traverse(\@grid, \@string, \%visited, $row, $col)) {
                $found = true;
                last;
            }
        }
    }
}

say $found ? 'true' : 'false';
