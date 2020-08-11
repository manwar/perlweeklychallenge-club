use strict;
use warnings;
##
# Write a script to print the smallest pair of Amicable Numbers.
##
use boolean; 
use Thread;
use constant RANGE_SIZE => 50; 
use constant THREAD_COUNT => 4;  

sub factor_sum{ 
    my(@numbers) = @_;
    my %number_sof; 
    foreach my $n (@numbers){  
        my @factors = (1);
            foreach my $j (2..sqrt($n)){
            push @factors, $j if $n % $j == 0;
            push @factors, ($n / $j) if $n % $j == 0 && $j ** 2 != $n;
        }    
        $number_sof{$n}=unpack("%32C*", pack("C*", @factors));  
    } 
    return \%number_sof;   
}

MAIN:{
    my %number_sof; 
    my @threads;
    my $range_start = 1;
    my $range_end = RANGE_SIZE; 
    my $found = false; 
    do{
        for(0 .. (THREAD_COUNT - 1)){
            my $t = Thread->new(\&factor_sum, ($range_start .. $range_end)); 
            push @threads, $t;  
            $range_start = $range_end + 1;
            $range_end = $range_start + RANGE_SIZE;  
        }  
        foreach my $t (@threads){
            my $sof = $t->join();
            @number_sof{keys %{$sof}} = values %{$sof};  
            foreach my $k (values %{$sof}){
                if($number_sof{$k}){
                    if($number_sof{$number_sof{$k}} && 
                       $number_sof{$number_sof{$k}} == $k && 
                       $number_sof{$k} != $k && !$found){
                           print "First amicable pair of numbers: $k " . $number_sof{$k} . " \n"; 
                           $found = true;   
                    }    
                }  
            }     
        }  
        @threads = (); 
    }while(!$found);     
}
