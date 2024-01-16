use v5.38;
##
# 6 out of 49 is a German lottery.
# Write a script that outputs six unique random integers from the range 1 to 49.
##
package SixOfFourtyNine{
    use Math::Random::Secure q/irand/;  
    sub pick_six{
        my @six;    
        {	
            my $r = irand(49) + 1;  
            push @six, $r if 0 == grep {$_ == $r} @six;
            redo unless @six == 6;  
	}
        return sort {$a <=> $b} @six;
    }

}

package main{  
    say join q/, /, SixOfFourtyNine::pick_six; 
}
