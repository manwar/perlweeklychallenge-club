use strict;
use warnings;
##
# You are given a positive integer $N.
# Write a script to generate all Rare Numbers of size $N, if any exist.
##
use Thread;
use constant THREAD_COUNT => 4;

sub rare_number_check{
    my($lower, $upper) = @_;
    my @rares; 
    {
        my $r = $lower;
        my $r1 = reverse($r);  
        if($r > $r1){
            my $rs = sqrt($r + $r1);  
            my $r1s = sqrt($r - $r1);  
            if($rs !~ m/\./ && $r1s !~ m/\./){
                push @rares, $lower; 
            } 
        } 
        $lower++; 
        redo unless $lower > $upper;
    }  
    return \@rares;
}

sub rare_number{
    my($n) = @_;
    my @rares; 
    my $lower = "1" . 0 x ($n - 1);
    my $upper = "1" . 9 x ($n - 1);
    my $increment = $lower;
    {
        my @threads;
        for(1 .. THREAD_COUNT){
            my $t = Thread->new(\&rare_number_check, $lower, $upper); 
            push @threads, $t;
            $lower = $upper + 1;
            $upper = $lower + $increment - 1;  
            last if(length($upper) == ($n + 1)); 
        }
        foreach my $t (@threads){
            my $rares = $t->join();
            push @rares, @{$rares}; 
        }  
        redo unless(length($upper) == ($n + 1)); 
    }
    return \@rares;  
}

MAIN:{
    my($N);
    $N=2;
    my $rares = rare_number($N); 
    print "$N digits: " . join(" ", @{$rares}) . "\n";
    $N=6;
    $rares = rare_number($N); 
    print "$N digits: " . join(" ", @{$rares}) . "\n";
    $N=9;
    $rares = rare_number($N); 
    print "$N digits: " . join(" ", @{$rares}) . "\n";
} 
