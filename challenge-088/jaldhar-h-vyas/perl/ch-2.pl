#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <file>
  
    <file>    a file describing a matrix of numbers where every line is a row in the matrix.
-USAGE-
    exit 0;
}

my $file = shift // usage();

my @matrix;
open my $fn, '<', $file or die "$OS_ERROR\n";
while (my $line = <$fn>) {
    chomp $line;
    push @matrix, [ $line =~ /(\d+)/g ];
}
close $fn;

my @spiral;
my $top = 0;
my $right = scalar @{$matrix[0]} - 1;
my $bottom = scalar @matrix - 1;
my $left = 0;

while ($top < scalar @matrix / 2) {
    if ($top == $bottom) {
        push @spiral, @{$matrix[$top]}[$left];
    } else {

        for my $i ($left .. $right) {
            push @spiral, @{$matrix[$top]}[$i];
        }

        for my $i ($top + 1 .. $bottom - 1) {
            push @spiral, @{$matrix[$i]}[$right];
        }

        for my $i (reverse ($left .. $right)) {
            push @spiral, @{$matrix[$bottom]}[$i];
        }

      for my $i (reverse ($top + 1 .. $bottom - 1)) {
            push @spiral, @{$matrix[$i]}[$left];
        }
    }

    $top++;
    $right--;
    $bottom--;
    $left++;
}

say join q{, }, @spiral;