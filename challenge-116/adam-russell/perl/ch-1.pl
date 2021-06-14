use strict;
use warnings;
##
# You are given a number $N >= 10.
# Write a script to split the given number such that the difference
# between two consecutive numbers is always 1, and it shouldn't have a leading 0.
# Print the given number if it impossible to split the number.
##
use boolean;
use AI::Genetic;

use constant THRESHOLD => 0;
use constant NUMBERS   => "1234";

sub no_op{
    my($x) = @_;
    return (caller(0))[3] if !defined($x);
    return $x;
}

sub get_1{
    my($s) = @_;
    return (caller(0))[3] if !defined($s);
    return substr($s, 0, 1);
}

sub get_2{
    my($s) = @_;
    return (caller(0))[3] if !defined($s);
    return substr($s, 0, 2);
}

sub get_3{
    my($s) = @_;
    return (caller(0))[3] if !defined($s);
    return substr($s, 0, 3);
}

sub get_4{
    my($s) = @_;
    return (caller(0))[3] if !defined($s);
    return substr($s, 0, 4);
}

sub fitness{
    my($genes) = @_;
    my $s = NUMBERS;
    my $fitness = -1 * (length($s) -1);
    my @operands;
    for my $gene (@{$genes}){
        if(my($i) = $gene->() =~ m/get_([1-4])/){
            push @operands, $gene->($s);
            return -1 * NUMBERS if length($s) < $i;
            $s = substr($s, $i) if length($s) >= $i;
        }
    }
    $s = NUMBERS;
    for(my $i = 0; $i < @operands - 1; $i++){
        if($operands[$i] == ($operands[$i + 1] - 1)){
            $fitness++; 
            my $chars = length($operands[$i]); 
            $s = substr($s, $chars);    
        }  
    }
    if($operands[@operands - 1] && $operands[@operands - 2]){
    if($operands[@operands - 1] == ($operands[@operands - 2] + 1)){
        my $chars = length($operands[@operands - 1]); 
        $s = substr($s, $chars);    
    }   
    }   
    $fitness *= length($s);
    return $fitness;
}

sub terminate{
    my($aig) = @_;
    my $top_individual = $aig->getFittest();
    if($top_individual->score == THRESHOLD){
        my $genes = $top_individual->genes();
        my $s = NUMBERS;
        my @operands;
        for my $gene (@{$genes}){
            if(my($i) = $gene->() =~ m/get_([1-4])/){
                push @operands, $gene->($s);
                $s = substr($s, $i);
            }
        }
        print join(",", @operands) . "\n"; 
        return true;
    }
    print NUMBERS . "\n"; 
    return false;
}

MAIN:{
    my $aig = new AI::Genetic(
        -fitness    => \&fitness,
        -type       => "listvector",
        -population => 50000,
        -crossover  => 0.9,
        -mutation   => 0.1,
        -terminate  => \&terminate,
    );
    my $genes = [];
    for (0 .. 7){
        push @{$genes}, [\&get_1, \&get_2, \&get_3, \&get_4, \&no_op],
    }
    $aig->init(
        $genes
    );
    $aig->evolve("tournamentUniform", 1000);
}
