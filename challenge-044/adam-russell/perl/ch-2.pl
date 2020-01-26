use strict;
use warnings;
##
# You have only $1 left at the start of the week. 
# You have been given an opportunity to make it $200. 
# The rule is simple: with every move you can either
# double what you have or add another $1. Write a script 
# to help you get $200 with the smallest number of moves.
##
use boolean;
use AI::Genetic;

use constant THRESHOLD => 0;

sub no_op{
    my($x) = @_;
    return (caller(0))[3] if !defined($x);
    return $x;
}

sub add_one{
    my($x) = @_;
    return (caller(0))[3] if !defined($x);
    return $x+1;
}

sub double{
    my($x) = @_;
    return (caller(0))[3] if !defined($x);
    return $x * 2;
}

sub fitness{
    my($genes) = @_;
    my $total = 1;
    my $count_no_op = 1;
    for my $gene (@{$genes}){
        $total = $gene->($total);
        $count_no_op++ if $gene->() =~ m/no/;
    }
    return 200 - $total if $total >= 200;
    return ($total - 200) * $count_no_op;
}

sub terminate{
    my($aig) = @_;
    my $top_individual = $aig->getFittest();
    if($top_individual->score == THRESHOLD){
        my @operations;
        my $genes = $top_individual->genes();
        for my $g (@{$genes}){
            push @operations, "add" if $g->() =~ m/add/;
            push @operations, "double" if $g->() =~ m/double/;
        }
        my $total = 1; 
        print "Start:     \$$total\n"; 
        for my $o (@operations){
            print "Add One:   \$" . ++$total . "\n" if($o eq "add"); 
            do{ $total = $total * 2; print "Double:    \$" .  $total . "\n" } if($o eq "double"); 
        } 
        return true;
    }
    return false;
}

MAIN:{
    my $aig = new AI::Genetic(
        -fitness    => \&fitness,
        -type       => "listvector",
        -population => 5000,
        -crossover  => 0.9,
        -mutation   => 0.01,
        -terminate  => \&terminate,
    );
    my $genes = [];
    for (0 .. 8){
        push @{$genes}, [\&add_one, \&double, \&no_op],
    }
    $aig->init(
        $genes
    );
    $aig->evolve("tournamentUniform", 1000);
}
