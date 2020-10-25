use strict;
use warnings;
##
# You are given a string $S with 3 or more words.
# Write a script to find the length of the string 
# except the first and last words ignoring whitespace.
##
sub count_most_words{
    my ($s) = @_;
    my $count = 0;
    my @a = split(/\s/, $s);
    map {$count += tr/a-zA-Z//d} @a[1 .. (@a - 2)];
    return $count;
}

MAIN:{
    my $S;
    $S = "The Weekly Challenge";
    print "$S --> " . count_most_words($S) . "\n";
    $S = "The purpose of our lives is to be happy";
    print "$S --> " . count_most_words($S) . "\n";
}