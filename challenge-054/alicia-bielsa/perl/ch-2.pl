use strict;
use warnings;
use Data::Dumper;

# Collatz Conjecture
# Contributed by Ryan Thompson

# It is thought that the following sequence will always reach 1:

    # $n = $n / 2 when $n is even
    # $n = 3*$n + 1 when $n is odd

# For example, if we start at 23, we get the following sequence:

# 23 → 70 → 35 → 106 → 53 → 160 → 80 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

# Write a function that finds the Collatz sequence for any positive integer. 
#Notice how the sequence itself may go far above the original starting number.

#Have your script calculate the sequence length for all starting numbers up to 1000000 (1e6),
# and output the starting number and sequence length for the longest 20 sequences.

my %hSequences =();
for  my $i (1..1000000){
    my @aSequence =  findCollatzSequence($i);
    push (@{$hSequences{$i}},@aSequence ) ;
}

sub findCollatzSequence {
    my $currentPoint = shift;
    my $endPoint = 1;
    my @aSequence = ();
    while ($currentPoint != $endPoint ){
        if (exists($hSequences{$currentPoint})){
            push (@aSequence, @{$hSequences{$currentPoint}});
            return @aSequence;
        }
        push (@aSequence, $currentPoint);
        if ($currentPoint % 2 == 0){
            $currentPoint = $currentPoint / 2;
        } else {
            $currentPoint = $currentPoint * 3 + 1;
        }
    }
    push (@aSequence, $endPoint);
    return @aSequence;
}

 my $count = 20;
 foreach my $number (sort {scalar(@{$hSequences{$b}}) <=> scalar(@{$hSequences{$a}}) } keys %hSequences) {
    print "$number\t".scalar(@{$hSequences{$number}})."\n";
    last if ( $count == 0 );
    $count--;
 }
 
# 837799	525
# 626331	509
# 939497	507
# 704623	504
# 927003	476
# 910107	476
# 511935	470
# 796095	468
# 767903	468
# 970599	458
# 546681	452
# 820023	450
# 820022	450
# 818943	450
# 410011	449
# 615017	447
# 922524	445
# 906175	445
# 886953	445
# 922526	445
# 938143	445
