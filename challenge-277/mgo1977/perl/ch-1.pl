#!/bin/perl -w


use Data::Dump qw(dump);


# Task 1: Count Common
# You are given two array of strings, @words1 and @words2.

# Write a script to return the count of words that appears in both arrays exactly once.

# Example 1
# Input: @words1 = ("Perl", "is", "my", "friend")
#        @words2 = ("Perl", "and", "Raku", "are", "friend")
# Output: 2

# The words "Perl" and "friend" appear once in each array.
# Example 2
# Input: @words1 = ("Perl", "and", "Python", "are", "very", "similar")
#        @words2 = ("Python", "is", "top", "in", "guest", "languages")
# Output: 1
# Example 3
# Input: @words1 = ("Perl", "is", "imperative", "Lisp", "is", "functional")
#        @words2 = ("Crystal", "is", "similar", "to", "Ruby")
# Output: 0


testMe(\&process, 'Example1', ["Perl", "is", "my", "friend"], ["Perl", "and", "Raku", "are", "friend"], 2);
testMe(\&process, 'Example2', ["Perl", "and", "Python", "are", "very", "similar"], ["Python", "is", "top", "in", "guest", "languages"], 1);
testMe(\&process, 'Example3', ["Perl", "is", "imperative", "Lisp", "is", "functional"], ["Crystal", "is", "similar", "to", "Ruby"], 0);

sub testMe {
    my $processor = shift;
    my $name = shift;
    my $input1 = shift;
    my $input2 = shift;
    my $expectedValue = shift;

    my $got = &$processor($input1, $input2);

    if ( $got==$expectedValue ) {
        print "[OK ] $name\n";
    }
    else {
        print "[ERR] $name :: got=$got, expectedValue=$expectedValue\n";
    }

}


sub process {
    my $input1 = shift;
    my $input2 = shift;

    my $total = 0;

    my $countMap1 = countWords($input1);
    my $countMap2 = countWords($input2);

    foreach my $word ( keys %$countMap1 ) {

        if ( 
            exists $countMap1->{$word} && $countMap1->{$word}==1 && 
            exists $countMap2->{$word} && $countMap2->{$word}==1
        ) {
            ++$total;
        }

    }

    return $total;

}


sub countWords {
    my $wordList = shift;

    my $map = {};

    if ( defined $wordList ) {
        $map->{$_}++ foreach ( @$wordList );
    }

    return $map;
}

