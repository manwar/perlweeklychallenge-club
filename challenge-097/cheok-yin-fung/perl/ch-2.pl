# The Weekly Challenge 097 Task 2
# Binary Substrings
# Usage: $ perl ch-2.pl $B $S
use strict;
use warnings;

my $B = $ARGV[0];
my $S = $ARGV[1];

die "The length of binary string is not acceptable." 
    unless ((length $B) % $S == 0);

my @substring;

my $num_of_substrings = (length $B) / $S;

for my $k (0..$num_of_substrings-1) {
    push @substring, substr( $B , $k*$S , $S );
}

my @voting;
for (0..$num_of_substrings-1) {
    $voting[$_] = 0;
}

for my $str (@substring) {
    for my $index (0..$S-1) {
        $voting[$index] 
            += int substr( $str, $index , 1 );
    }
}

my $num_of_filps = 0;

for my $i (0..$S-1) {
    my $partial_result = 0;
    if ( $voting[$i] > ( ($num_of_substrings-1)/2 ) ) {
        $num_of_filps += $num_of_substrings - $voting[$i];
    } 
    else {
        $num_of_filps += $voting[$i];
    }    

}

print "Number of Filps: ";
print $num_of_filps;

print "\n";
