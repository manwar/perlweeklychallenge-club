use strict;
use warnings;
##
# At a party a pie is to be shared by 100 guests.
# The first guest gets 1% of the pie, the second
# guest gets 2% of the remaining pie, the third
# gets 3% of the remaining pie, the fourth gets 4% and so on.
# Write a script that figures out which guest gets the largest piece of pie.
##
use constant PIE_SIZE => 100;
my $pie_remaining = PIE_SIZE;
my @pie_eaters;
my $eater = 1;
my $eaten;
do{
    $eaten = $pie_remaining * ($eater * .01);
    $pie_eaters[$eater] = $eaten;
    $pie_remaining = $pie_remaining - $eaten;
    print "$eater $eaten $pie_remaining\n";
    $eater++;
} while($pie_remaining > 0 && $eaten > 0);
