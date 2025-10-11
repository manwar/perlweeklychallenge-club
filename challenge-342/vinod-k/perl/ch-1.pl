#!/usr/bin/perl
use strict;
use warnings;

sub format_string {
    my ($str) = @_;

    my @letters = sort grep { /[a-z]/ } split //, $str;
    my @digits  = sort grep { /\d/ }   split //, $str;

    return "" if abs(@letters - @digits) > 1;

    # Determine which type starts firs
    my $start_with_digit = @digits > @letters ? 1 :
                           @digits < @letters ? 0 :
                           ($digits[0] lt $letters[0] ? 1 : 0);

    my @result;
    while (@letters or @digits) {
        if ($start_with_digit) {
            push @result, shift @digits if @digits;
            push @result, shift @letters if @letters;
        } else {
            push @result, shift @letters if @letters;
            push @result, shift @digits  if @digits;
        }
    }

    return join "", @result;
}

for my $str ("a0b1c2", "abc12", "0a2b1c3", "1a23", "ab123") {
    print "Input:  $str\n";
    print "Output: ", format_string($str), "\n\n";
}
