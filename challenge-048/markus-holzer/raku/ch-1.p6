# The most common approach, and probably the simplest solution to this challenge
# is to create an array of men, and then keep taking two from the front and putting the first of 
# them to the back of the array until it has only one member left.
#
# A concise version of this looks like

given my @men = 1..50 { .push( .splice(0,2).first ) while .elems > 1 };
say @men.first;

# But, the problem naturally lends itself to be expressed in terms of a circular linked list,
# a data structure most young people don't learn about in school anymore.
# This has linear complexity and is, if I can trust my benchmarks 3 times faster than the 
# solution above.

role Concatenationem { has $.vicinus is rw; }
class Moribunda is Int does Concatenationem { };

sub bicimare-sine-fine( Int $homines where * > 1 ) 
{
    my $armis = my $primus = Moribunda.new(1);

    for 2..$homines
    { 
        my $homine = Moribunda.new($_); 
        $armis.vicinus = $homine; 
        $armis = $homine; 
    }
    
    $armis = $armis.vicinus = $primus;

    while $armis != $armis.vicinus 
    {
        $armis = $armis.vicinus = $armis.vicinus.vicinus;
    }

    $armis;
}

say bicimare-sine-fine( 50 );

# The following solution looks at the number of men in each round of
# killing and then use rotor(2) to split them up into killer / victim tuples,
# from which only the survivors will be shoved into the next round.

sub rotor-kill( $n )
{
    my @men = 1..$n;
    
    while @men.elems > 1
    {
        if @men.elems %% 2 
        {
            # When the number of men is even, we know the very last man 
            # in line will die and we can start the next round at the beginning.
            @men = @men.rotor(2).map: *.first;
        } 
        else 
        {
            # When the number of men is odd, the last man survives and will 
            # kill the first in the next round, so we need to skip over the 
            # poor fellow.
            @men = @men.rotor(2, :partial).skip.map: *.first;
        }
    }
    
    @men.first;
}

say rotor-kill( 50 );