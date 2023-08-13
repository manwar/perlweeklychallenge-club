#!usr/bin/perl
use v5.38;

# Challenge 229 - 1 - Lexicographic Order
# You are given an array of strings.
# Write a script to delete element which is not lexicographically sorted (forwards or backwards) and return the count of deletions.

# first commit with new strawberry release, neat!

countRemovals(["abc", "bce", "cae"]);       # 1
countRemovals(["yxz", "cba", "mon"]);       # 2

sub countRemovals($arrRef)
{
    my $retVal = @$arrRef - @{deleteNotOrdered($arrRef)};
    say $retVal;
    return $retVal;
}

sub deleteNotOrdered($arrRef)
{
    # order it both ways and check each
    my @newArray = grep{ (join('', sort split("", $_)) eq $_) or (join('', sort { $b cmp $a} split("", $_)) eq $_)} @$arrRef;
    
    return \@newArray;
}