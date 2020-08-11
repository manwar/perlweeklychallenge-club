use strict;
use warnings;
##
# You are given a string "123456789". Write a script 
# that would insert "+" or "-" in between digits so
# that when you evaluate, the result should be 100.
##
use boolean;
use AI::Genetic;

use constant THRESHOLD => 0;
use constant NUMBERS   => "123456789";

sub no_op{
    my($x) = @_;
    return (caller(0))[3] if !defined($x);
    return $x;
}

sub add{
    my($x, $y) = @_;
    return (caller(0))[3] if !defined($x);
    return $x + $y;
}

sub subtract{
    my($x, $y) = @_;
    return (caller(0))[3] if !defined($x);
    return $x - $y;
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
    my $total = 0;
    my @operands = ($total);
    for my $gene (@{$genes}){
        if(my($i) = $gene->() =~ m/get_([1-4])/){
            return (-1 * NUMBERS) if(@operands == 2);
            return (-1 * NUMBERS) if(length($s) < $i);
            push @operands, $gene->($s);  
            $s = substr($s, $i);  
        }
        if($gene->() =~ m/add/){
            return (-1 * NUMBERS) if(@operands != 2);
            $total = add(@operands); 
            @operands = ($total);  
        } 
        if($gene->() =~ m/subtract/){
            return (-1 * NUMBERS) if(@operands != 2);
            $total = subtract(@operands); 
            @operands = ($total);  
        } 
    }
    return 100 - $total if $total > 100;
    return $total - 100;
}

sub terminate{
    my($aig) = @_;
    my $top_individual = $aig->getFittest();
    if($top_individual->score == THRESHOLD){
        my @operations;
        my $genes = $top_individual->genes();
        my $n = NUMBERS;
        my $s = ""; 
        my $operand;
        my $op_count = 0;
        for my $g (@{$genes}){
            if(my($i) = $g->() =~ m/get_([1-4])/){
                $operand = $g->($n);
                $n = substr($n, $i);  
            }
            if($g->() =~ m/add/){
                $s .= "+ $operand " if $op_count > 0;
                $s = "$operand " if $op_count == 0;
                $op_count++;  
            }
            if($g->() =~ m/subtract/){
                $s .= "- $operand " if $op_count > 0;  
                $s = "$operand  " if $op_count == 0;
                $op_count++;  
            }
        }
        print "$s= " . eval($s) . "\n";
        return true;
    }
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
        push @{$genes}, [\&add, \&subtract, \&get_1, \&get_2, \&get_3, \&get_4, \&no_op],
    }
    $aig->init(
        $genes
    );
    $aig->evolve("tournamentUniform", 1000);
}
