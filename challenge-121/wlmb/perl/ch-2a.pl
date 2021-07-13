#!/usr/bin/env perl
# Perl weekly challenge 121
# Task 2: The travelling salesman. Simulated Annealing
#
# See https://wlmb.github.io/2021/07/12/PWC121/#task-2-the-travelling-salesman
use strict;
use warnings;
use v5.12;
use PDL;

die "Usage: ./ch-2a.pl cities steps high low data" unless @ARGV==5;
my ($cities, $steps, $high, $low, $data)=@ARGV;
open(my $fh, '>', $data) or die "Couldn't open $data: $!";
srand(0); #seed, for tests
my $M=random($cities, $cities); # generate distances matrix
$M->diagonal(0,1).=0; # zero the diagonal
$M= ($M+$M->transpose)/2; #symmetrize (?)
my $L0=$high; # starting 'temperature'
my $L_stop=$low;
my $factor=($low/$high)**(1/$steps);
my $route=pdl(0..$cities-1); #initial route
my $L=distance($route);
while($L0>$L_stop){
    my $new_route=step($route);
    my $new_L=distance($route);
    my $dL=$new_L-$L;
    if($dL<=0 || random(1)<exp(-$dL/$L0)){
	$route=$new_route; # accept
	$L=$new_L;
    }
    say $fh $L;
    $L0*=$factor;
}
my $best_route=append($route, 0);
say "Distance table: $M\nSteps: $steps\nCities: $cities\nRoute: $best_route\nLength: $L";

sub step {
    my $i=random(2)*($cities-1)+1;
    my $new_route=$route->copy;
    $new_route->index($i).=$new_route->index($i->rotate(1));
    return $new_route;
}

sub distance {
    my $r=shift;
    my $indices=pdl($r->rotate(-1),$r)->transpose;
    return $M->indexND($indices)->sumover;
}
