#Survivor
#There are 50 people standing in a circle in position 1 to 50. The person standing at position 1 has a sword. He kills the next person i.e. standing at position 2 and pass on the sword to the immediate next i.e. person standing at position 3. Now the person at position 3 does the same and it goes on until only one survives.
#
#Write a script to find out the survivor.
use strict;
use warnings;

my $numberPeople = 50;
my $numberPeopleAlive = $numberPeople;
my @aPeople = ();
foreach my $position (1..$numberPeople){
    my $nextPosition = $position == $numberPeople ? 1 : $position +1;    
    my %hTmp = (  'nextPosition' => $nextPosition);
    push (@aPeople, \%hTmp);
}


my $swordPosition  = 1;
while ($numberPeopleAlive > 1){  

    my $killPosition = $aPeople[ $swordPosition - 1 ]->{'nextPosition'};
    $aPeople[ $swordPosition - 1 ]->{'nextPosition'}  = $aPeople[ $killPosition - 1 ]->{'nextPosition'};
    $swordPosition = $aPeople[ $killPosition - 1 ]->{'nextPosition'};
    $numberPeopleAlive--;

} 

print "Last Position Alive : $swordPosition\n";