#!/usr/bin/env perl
# Perl weekly challenge 121
# Task 2: The traveling salesman. Simulated Annealing. Obeying triangle inequality.
#
# See https://wlmb.github.io/2021/07/12/PWC121/#task-2-the-traveling-salesman
use strict;
use warnings;
use v5.12;
use PDL;

die "Usage: ./ch-2a.pl cities steps high low output" unless @ARGV==5;
my ($cities, $steps, $high, $low, $output)=@ARGV;
open(my $fh, '>', $output) or die "Couldn't open $output: $!";
srand(0); #seed, for tests
my $locations=random(2,$cities); #positions of cities in a plane
my $M=(($locations->dummy(2)-$locations->dummy(1))**2)->sumover->sqrt; # euclidean distances
my $L0=$high; # starting 'temperature'
my $L_stop=$low;
my $factor=($low/$high)**(1/$steps);
my $route=pdl(0..$cities-1); #initial route
my $L=distance($route);
while($L0>$L_stop){
    my $new_route=step($route);
    my $new_L=distance($new_route);
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
