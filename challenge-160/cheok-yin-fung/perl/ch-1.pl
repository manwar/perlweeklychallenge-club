#!/usr/bin/perl
# The Weekly Challenge 160
# Task 1 Four is Magic
use v5.22.0;
use warnings;


fim($ARGV[0]) if defined($ARGV[0]);



sub fim {
    my @num = ("zero", "one", "two", "three", "four", "five",
               "six", "seven", "eight", "nine");
    my $spell = "four is magic.";
    my $c = $_[0];
    if ($c == 4) {
        print ucfirst($spell), "\n";
        return;
    }
    $num[$c] = ucfirst($num[$c]);
    while ($c != 4) {
        print $num[$c];
        $c = length $num[$c];
        print " is $num[$c], ";
    }
    print "$spell\n";
}



=pod Testing

for (1..9) {
    fim($_);
    print "\n";
}
