#!/usr/bin/env perl

use Modern::Perl;

say reverse_letters(shift);

sub reverse_letters {
    my($string) = @_;
    my @rev_letters = reverse grep {/[a-z]/i} split //, $string;
    my @output = split //, $string;
    for my $i (0 .. $#output) {
        next if $output[$i] !~ /[a-z]/i;
        $output[$i] = shift @rev_letters;
    }
    return join '', @output;
}
