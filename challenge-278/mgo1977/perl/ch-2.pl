#!/bin/perl -w


# Task 2: Reverse Word
# Submitted by: Mohammad Sajid Anwar
# You are given a word, $word and a character, $char.

# Write a script to replace the substring up to and including $char with its characters sorted alphabetically. If the $char doesn’t exist then DON'T do anything.

# Example 1
# Input: $str = "challenge", $char = "e"
# Ouput: "acehllnge"

# Example 2
# Input: $str = "programming", $char = "a"
# Ouput: "agoprrmming"

# Example 3
# Input: $str = "champion", $char = "b"
# Ouput: "champion"

testMe(\&process, 'Example1', "challenge", "e", "acehllnge");
testMe(\&process, 'Example2', "programming", "a", "agoprrmming");
testMe(\&process, 'Example3', "champion", "b", "champion");
testMe(\&process, 'Example4', "champion", "n", "achimnop");
testMe(\&process, 'Example5', "", "n", "");
testMe(\&process, 'Example6', "purePerl", "P", "Pepruerl");

sub testMe {
    my $processor = shift;
    my $name = shift;
    my $input1 = shift;
    my $input2 = shift;
    my $expectedValue = shift;

    my $got = &$processor($input1, $input2);

    if ( $got eq $expectedValue ) {
        print "[OK ] $name\n";
    }
    else {
        print "[ERR] $name :: got=$got, expectedValue=$expectedValue\n";
    }

}

sub process {
    my $word = shift;
    my $char = shift;

    my $index = index($word, $char);

    if ( $index==-1 ) {
        return $word;
    }

    my $p1 = substr($word, 0, $index+1);
    my $p2 = substr($word, $index+1);

    my $sortedP1 = join('', sort { $a cmp $b } split(//, $p1));

    # print "word='$word' char='$char' (index=$index) p1='$p1' sortedP1='$sortedP1' p2='$p2'\n";

    return $sortedP1 . $p2;
}



