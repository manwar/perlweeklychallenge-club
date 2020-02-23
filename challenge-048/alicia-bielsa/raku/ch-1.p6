use v6;



my $numberPeople = 50;
my $numberPeopleAlive = $numberPeople;
my @aPeople;
for 1..$numberPeople {
    my $nextPosition = $_ == $numberPeople ?? 1 !! $_ +1;    
    @aPeople.push({'nextPosition' =>  $nextPosition});
}

my $swordPosition  = 1;
while $numberPeopleAlive > 1 {  
    my $killPosition =  @aPeople[ $swordPosition-1 ]<nextPosition>;
    @aPeople[ $swordPosition-1 ]<nextPosition>  = @aPeople[ $killPosition-1 ]<nextPosition>;
    $swordPosition = @aPeople[ $killPosition-1 ]<nextPosition>;
    $numberPeopleAlive--;

} 

print "Last Position Alive : $swordPosition\n";