#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <file>
  
    <file>    a file describing a matrix of 1's and 0's where every line is a row in the matrix.
-USAGE-
    exit 0;
}

sub all {
    my @array = @_;

    for (@array) {
        if ($_ != 1) {
            return undef;
        }
    }

    return 1;
}

my $file = shift // usage();

my @matrix;
open my $fn, '<', $file or die "$OS_ERROR\n";
while (my $line = <$fn>) {
    chomp $line;
    push @matrix, [ $line =~ /(0|1)/g ];
}
close $fn;

my $maxheight = 0;
my $maxwidth = 0;

for my $m (0 .. scalar @matrix - 1) {
    for my $n (0 .. scalar @{$matrix[$m]} - 1) {
        if (@{$matrix[$m]}[$n] == 1) {
            my $row = $m;
            my $col = $n;
            my $left = $n;
            my $height = 0;
            my $width = 0;
            while ($col < scalar @{$matrix[$row]} && @{$matrix[$row]}[$col] == 1) {
                $width++;
                $col++;
            }

            while ($row < scalar @matrix && all(@{$matrix[$row]}[$left .. $left + $width - 1])) {
                $height++;
                $row++;
            }

            if ($height * $width > $maxheight * $maxwidth) {
                $maxheight = $height;
                $maxwidth = $width;
            }
        }
    }
}

if ($maxheight * $maxwidth < 2) {
    say '0';
} else {
    for (0 .. $maxheight - 1) {
        say q{[ }, "1 " x $maxwidth, q{]};
    }
}