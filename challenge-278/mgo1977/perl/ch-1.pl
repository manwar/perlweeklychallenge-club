#!/bin/perl -w


use Data::Dump qw(dump);


# Task 1: Sort String
# Submitted by: Mohammad Sajid Anwar
# You are given a shuffle string, $str.

# Write a script to return the sorted string.

# A string is shuffled by appending word position to each word.

# Example 1
# Input: $str = "and2 Raku3 cousins5 Perl1 are4"
# Output: "Perl and Raku are cousins"
# Example 2
# Input: $str = "guest6 Python1 most4 the3 popular5 is2 language7"
# Output: "Python is the most popular guest language"
# Example 3
# Input: $str = "Challenge3 The1 Weekly2"
# Output: "The Weekly Challenge"


testMe(\&process, 'Example1', "and2 Raku3 cousins5 Perl1 are4", "Perl and Raku are cousins");
testMe(\&process, 'Example2', "guest6 Python1 most4 the3 popular5 is2 language7", "Python is the most popular guest language");
testMe(\&process, 'Example3', "Challenge3 The1 Weekly2", "The Weekly Challenge");

sub testMe {
    my $processor = shift;
    my $name = shift;
    my $input1 = shift;
    my $expectedValue = shift;

    my $got = &$processor($input1);

    if ( $got eq $expectedValue ) {
        print "[OK ] $name\n";
    }
    else {
        print "[ERR] $name :: got='$got', expectedValue='$expectedValue'\n";
    }

}


sub process {
    my $input1 = shift;

    my @words = split(/\s+/, $input1);

    my @sorted = sort {
        my $i1 = getIndex($a);
        my $i2 = getIndex($b);
        $i1 <=> $i2;
    } @words;

    my $str = join(' ', map { stripIndex($_) } @sorted);

    # print "words=" . dump(\@words) . "\n";
    # print "sorted words=" . dump(\@sorted) . "\n";
    # print "str=" . $str . "\n";

    return $str;

}


sub getIndex {
    my $word = shift;

    if ( $word =~ /(\d+)$/ ) {
        return int($1);
    }

    return -1;
}


sub stripIndex {
    my $word = shift;

    $word =~ s/\d+$//;

    return $word;
}
