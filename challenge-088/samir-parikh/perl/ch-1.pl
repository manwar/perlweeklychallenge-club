#!/usr/local/bin/perl

use warnings;
use strict;
use diagnostics;
use v5.10;

# run program as:
# $ ./ch-1.pl "100, 4, 50, 3, 2"
my @N = split /, /, $ARGV[0];
my @M;
my $output_string = "";

for (my $i = 0; $i < scalar(@N); $i++) {
    my $product = 1;
    my $m_string = "\$M[" . $i . "] = ";
    my $first = 1;
    for (my $j = 0; $j < scalar(@N); $j++) {
        my $print_x;
        if ($i != $j) {
            $product = $product * $N[$j];
            if ($first) {
                $print_x = "";
                $first = 0;
            } else {
                $print_x = " x ";
            }
            $m_string .= $print_x . $N[$j]; 
        }
    }
    push (@M, $product);
    $m_string .= " = " . $product;
    $output_string .= "\t". $m_string . "\n";
}

say "Input:\n\t\@N = (", join(", ", @N), ")";
say "Output:";
say "\t\@M = (", join(", ", @M), ")\n";
say "$output_string";
