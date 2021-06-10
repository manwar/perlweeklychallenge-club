use strict;
use warnings;
##
# Write a script to generate self-descriptive numbers.
##
use Thread; 
use boolean;
use constant SDN_COUNT => 3;
use constant THREAD_COUNT => 4;
use constant RANGE_SIZE => 10_000;

sub self_describing{
    my($i) = @_;
    my @digits = split(//, $i);
    for my $x (0 .. @digits - 1){
        my $count = 0;
        for my $j (0 .. @digits - 1){
            $count++ if($digits[$j] == $x);
            return false if($count > $digits[$x]);
        }
        return false if($count != $digits[$x]);
    }
    return true;
}

sub self_describing_number{
    my($start, $end) = @_;  
    my @r = (); 
    for(my $i = $start; $i < $end; $i++){
        push @r, [length($i), $i] if(self_describing($i));  
    }   
    return \@r;  
}

MAIN:{
    my @threads; 
    my $count = 0; 
    my $lower = 1; 
    my $upper = RANGE_SIZE; 
    do{
        for(0..(THREAD_COUNT - 1)){  
            my $t = Thread->new(\&self_describing_number, ($lower, $upper));
            push @threads, $t;  
            $lower = $upper + 1;  
            $upper = $lower +  RANGE_SIZE;  
        }  
        foreach my $t (@threads){  
            my $sdns = $t->join();                 
            foreach my $sdn (@{$sdns}){ 
                print "Base " . $sdn->[0] . ":" .  $sdn->[1] . "\n" if $count < SDN_COUNT; 
                $count++;  
            }  
        }   
        @threads = ();   
    } while($count < SDN_COUNT);
}
