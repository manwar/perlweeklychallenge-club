#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $n = 2500;
my $i;
my $j;
my @pentagonal_list = ();
my %pentagonal_table = ();
my $done = 0;

# Since we'll be dealing with sums,
# calculate twice the quantity of
# Pentagonal Numbers as the range we'll be
# scanning...
$i = 1;
for($i=1; $i<=($n * 2); $i++){
    # Store the Pentagonal Numbers from 1 to
    # $n in a list, and do the same from 1
    # to $n * 2 in a hash to make a reverse
    # lookup table
    my $P = P($i);

    if($i <= $n){
        $pentagonal_list[$i] = $P;
    }
    $pentagonal_table{$P} = $i;
}

for($i=1; $i<$n; $i++){
    for($j=$i+1; $j<=$n; $j++){
        if(
            # If the sum is a Pentagonal
            # Number...
            $pentagonal_table{
                $pentagonal_list[$i] + $pentagonal_list[$j]
            }

            # AND...
            &&

            # the difference is a Pentagonal
            # Number...
            $pentagonal_table{
                abs($pentagonal_list[$i] - $pentagonal_list[$j])
            }
        ){
            # ...then we're done
            $done = 1;
        }
        last if($done);
    }
    last if($done);
}

# Uh oh...
unless($done){
    warn("Qualifying Pentagonal Numbers not found with \$n = $n\n");
    exit(1);
}

print("\nThe first two qualifying Pentagonal Numbers are:\n");
printf(
    "P(%d) + P(%d) =  %d + %d  = %d = P(%d)\n",
    $i, $j,
    $pentagonal_list[$i], $pentagonal_list[$j],
    $pentagonal_list[$i] + $pentagonal_list[$j],
    $pentagonal_table{$pentagonal_list[$i] + $pentagonal_list[$j]}
);
printf(
    "P(%d) - P(%d) = |%d - %d| = %d = P(%d)\n\n",
    $i, $j,
    $pentagonal_list[$i], $pentagonal_list[$j],
    abs($pentagonal_list[$i] - $pentagonal_list[$j]),
    $pentagonal_table{abs($pentagonal_list[$i] - $pentagonal_list[$j])}
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the Nth Pentagonal Number (see
# https://en.wikipedia.org/wiki/Pentagonal_number )
# Takes one argument:
# * The number N
# Returns on success:
# * The Nth Pentagonal Number
# Returns on error:
# * Undef if N is not 1 or larger
################################################################################
sub P{
    my $n = int(shift());

    return(undef)
        if($n < 1);

    return($n * (3 * $n - 1) / 2);

}



