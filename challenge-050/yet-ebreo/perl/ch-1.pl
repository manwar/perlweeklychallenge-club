#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

# Write a script to merge the given intervals where ever possible.
# [2,7], [3,9], [10,12], [15,19], [18,22]
# The script should merge [2, 7] and [3, 9] together to return [2, 9].
# Similarly it should also merge [15, 19] and [18, 22] together to return [15, 22].
# The final result should be something like below:
# [2, 9], [10, 12], [15, 22]
my @skip;
my @output;

my @range = ([10,12], [2,7], [3,9], [15,19], [18,22], [-1,3]);

#Print out the original intervals
printf "Given:  ";
for my $x (@range) {
    printf "(@{$x}) "
}

#Sort it by the start of the interval (index [0])
#Assuming proper intervals only, such that index [0] < index [1]
@range = sort { @{$a}[0] - @{$b}[0] } @range;

for my $n (0..~-@range) {
    #Store interval in $o and $p then consider $p as $max
    my ($o,$p) = @{$range[$n]};
    my $max = $p;
    for my $m ($n+1..~-@range) {
        #Check next interval save to $q and $r
        my ($q,$r) = @{$range[$m]};

        #then check if $q is in between $o and $p
        if (($q>$o) && ($q<=$p)) {
            #Consider $r as max if $r > $max
            $max = $r if $r>$max;
            #Remove interval $m from list (by adding it in @skip array)
            push @skip, $m
        }
    }
    #Update output with the new interval if
    #$n can not be found in " @skip " using regex
    " @skip " !~ / $n / && push @output, [$o,$max];
}

#Print the merged intervals
printf "\n\nMerged: ";
for my $x (@output) {
    printf "(@{$x}) "
}
printf "\n";

=begin
#Using the given intervals from the example
perl .\ch-1.pl
Given:  (10 12) (2 7) (3 9) (15 19) (18 22)

Merged: (2 9) (10 12) (15 22)


#With negative number
perl .\ch-1.pl
Given:  (10 12) (2 7) (3 9) (15 19) (18 22) (-1 3)

Merged: (-1 9) (10 12) (15 22)
=cut