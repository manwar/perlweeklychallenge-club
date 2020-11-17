#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub process {
    my ($file) = @_;
    my @puzzle;

    open my $fn, '<', $file or die "$OS_ERROR\n";
    local $RS = undef;
    my $data = <$fn>;
    close $fn;

    $data =~ s/_/0/g;
    my @lines = split /\n/, $data;
    for my $line (@lines) {
        push @puzzle, [ grep { /\d/ } split //, $line];
    }

    return @puzzle;
}

sub columns {
    my ($puzzle) = @_;
    my @columns;

    for my $i (0 .. scalar @{$puzzle} - 1) {
        for my $j (0 .. scalar @{$puzzle->[$i]} - 1) {
            push @{$columns[$i]}, @{$puzzle->[$j]}[$i];
        } 
    } 

    return @columns;
}

sub inBox {
    my ($puzzle, $row, $col, $num) = @_;
    my @box;

    for my $i ($row .. $row + 2) {
        push @box, @{$puzzle->[$i]}[$col .. $col + 2];
    }

    return scalar grep { $_ == $num; } @box;
}

sub inCol {
    my ($columns, $col, $num) = @_;
    return scalar grep { $_ == $num; } @{$columns->[$col]};
}

sub inRow {
    my ($puzzle, $row, $num) = @_;
    return scalar grep { $_ == $num; } @{$puzzle->[$row]};
}

sub isValid {
    my ($puzzle, $row, $col, $num) = @_;
    my @columns = columns($puzzle);

    return
        !inRow($puzzle, $row, $num) &&
        !inCol(\@columns, $col, $num) &&
        !inBox($puzzle, $row - $row % 3, $col - $col % 3, $num);
}

sub solve {
    my ($puzzle) = @_;

    for my $row (0 .. scalar @{$puzzle} - 1) {
        for my $col (0 .. scalar @{$puzzle->[$row]} - 1) {
            if ($puzzle->[$row][$col] == 0) {


                for my $num (1 .. 9) {
                    if (isValid($puzzle, $row, $col, $num)) {
                        $puzzle->[$row][$col] = $num;
                        if(solve($puzzle)) {
                            return 1;
                        }
                        $puzzle->[$row][$col] = 0;
                    }
                }

                return undef;
            }
        }
    }

    return 1;
}

my $sudoku = shift;
my @puzzle = process($sudoku);

if (solve(\@puzzle)) {
    for my $row (@puzzle) {
        say q{[ }, (join q{ }, @{$row}), q{ ]};
    }
} else {
    say 'Unsolvable.';
}