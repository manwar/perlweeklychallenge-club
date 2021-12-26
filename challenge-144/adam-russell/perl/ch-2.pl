use strict;
use warnings;
##
# You are given two positive numbers, $u and $v. Write a script to generate the
# Ulam Sequence having at least 10 Ulam numbers where $u and $v are the first two 
# Ulam numbers.    
##
use constant ULAM_LIMIT => 10;   

sub ulam{
    my($u, $v) = @_;    
    my %pairs; 
    my @ulam = ($u, $v); 
    my $w = $u + $v;  
    push @ulam, $w;  
    $pairs{"$u,$v"} = $w; 
    $pairs{"$u,$w"} = $u + $w; 
    $pairs{"$v,$w"} = $v + $w; 
    do{
        my @sums = sort {$a <=> $b} grep{my $sum = $_; my @values = grep{$sum == $_} values %pairs; $sum if @values == 1 && $sum > $ulam[@ulam - 1]} values %pairs; 
        my $u = $sums[0]; 
        push @ulam, $u;
        for my $pair (keys %pairs){
            my($s, $t) = split(/,/, $pair);  
            $pairs{"$s,$u"} = $s + $u;
            $pairs{"$t,$u"} = $t + $u;
        }   
    }while(@ulam < ULAM_LIMIT);
    return @ulam;  
}

MAIN:{
    my @ulam;
    @ulam = ulam(1, 2);   
    {
        print shift @ulam;
        print ", ";
        redo if @ulam > 1;
    } 
    print shift @ulam;
    print "\n";

    @ulam = ulam(2, 3);   
    {
        print shift @ulam;
        print ", ";
        redo if @ulam > 1;
    } 
    print shift @ulam;
    print "\n";

    @ulam = ulam(2, 5);   
    {
        print shift @ulam;
        print ", ";
        redo if @ulam > 1;
    } 
    print shift @ulam;
    print "\n";
}
