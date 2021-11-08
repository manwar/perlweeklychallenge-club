use strict;
use warnings;
##
# You are given a NxN matrix containing the distances between N cities.
# Write a script to find a round trip of minimum length visiting 
# all N cities exactly once and returning to the start.
##
use boolean;
use AI::Genetic;

use constant N => 20;

my @matrix= ([0, 5, 2, 7], 
             [5, 0, 5, 3],  
             [3, 1, 0, 6],  
             [4, 5, 4, 0]);  

sub fitness{
    my($genes) = @_;  
    my $cost = 0;
    return -1 if $genes->[0] != $genes->[@{$genes} - 1]; 
    my @path = sort {$a <=> $b} @{$genes}[0 .. @{$genes} - 2];  
    for my $i (0 .. (@path - 2)){
        return -1 if $path[$i] == $path[$i + 1]; 
    } 
    for my $i (0 .. @{$genes} - 2){
        $cost += $matrix[$genes->[$i]][$genes->[$i + 1]]; 
    }  
    return 1/$cost;  
}

sub terminate{
    return true; 
}

MAIN:{
    srand(121); 
    my $aig = new AI::Genetic(
        -fitness    => \&fitness,
        -type       => "rangevector",
        -population => 500,
        -crossover  => 0.9,
        -mutation   => 0.1,
    );
    my $genes = [];
    for (0 .. N + 1){
        push @{$genes}, [0, N]; 
    }
    @matrix = ();
    for (0 .. N){
        my $row = [];
        for my $i (0 .. N){
            push @{$row}, int(rand(N * 2 + 1));  
        } 
        push @matrix, $row; 
    }
    $aig->init(
        $genes
    );
    $aig->evolve("tournamentUniform", 100000);
    my $path = $aig->getFittest()->genes(); 
    print join(",", @{$path}) . "\n"; 
    my $cost;
    for my $i (0 .. @{$path} - 2){
        $cost += $matrix[$path->[$i]][$path->[$i + 1]]; 
    }  
    print "cost: $cost\n";  
}
