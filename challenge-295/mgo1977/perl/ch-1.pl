#!/bin/perl -w


use Data::Dump qw(dump);


# Task 1: Word Break
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str, and list of words, @words.

# Write a script to return true or false whether the given string can be segmented into a space separated sequence of one or more words from the given list.

# Example 1
# Input: $str = 'weeklychallenge', @words = ("challenge", "weekly")
# Output: true
# Example 2
# Input: $str = "perlrakuperl", @words = ("raku", "perl")
# Output: true
# Example 3
# Input: $str = "sonsanddaughters", @words = ("sons", "sand", "daughters")
# Output: false



testMe(\&process, 'Example1', "weeklychallenge", ["challenge", "weekly"], 1);
testMe(\&process, 'Example2', "perlrakuperl", ["raku", "perl"], 1);
testMe(\&process, 'Example3', "sonsanddaughters", ["sons", "sand", "daughters"], 0);
testMe(\&process, 'Example4', "sonsanddaughters", ["son", "sand", "daughters"], 1);
testMe(\&process, 'Example5', "sonsanddaughters", ["son", "sand", "daughter"], 0);

sub testMe {
    my $processor = shift;
    my $name = shift;
    my $input1 = shift;
    my $input2 = shift;
    my $expectedValue = shift;

    my $got = &$processor($input1, $input2);

    if ( $got == $expectedValue ) {
        print "[OK ] $name\n";
    }
    else {
        print "[ERR] $name :: got='$got', expectedValue='$expectedValue'\n";
    }

}


sub process {
    my $str = shift;
    my $words = shift;

    my $output = 0;

    foreach my $word ( @$words ) {
        # print "word='$word'\n";

        if ( $str !~ /$word/ ) {
            return 0;
        }

        $str =~ s/$word//g;

    }

    # any characters remaining
    if ( length($str) > 0 ) {
        return 0;
    }

    return 1;

}

