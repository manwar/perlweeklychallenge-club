use strict;
use  warnings;
##
# Given a list of numbers @n,  generate the skip summations.
##
sub skip_summations{
    my @lines = ([@_]);
    for my $i (1 .. @_ - 1){
        my @skip = @{$lines[$i - 1]}[1 .. @{$lines[$i - 1]} - 1];
        my $line = [map {my $j = $_; $skip[$j] + unpack("%32I*", pack("I*", @skip[0 .. $j - 1]))} 0 .. @skip - 1];
        push @lines, $line;
    }
    return @lines;
}

MAIN:{
    for my $line (skip_summations(1, 2, 3, 4, 5)){
        print join(" ", @{$line}) . "\n";
    }
    print "\n";
    for my $line (skip_summations(1, 3, 5, 7, 9)){
        print join(" ", @{$line}) . "\n";
    }
}
