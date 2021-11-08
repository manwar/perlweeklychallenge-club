#!/usr/bin/env perl
# Perl weekly challenge 118
# Task 2: Adventure of knight
#
# See https://wlmb.github.io/2021/06/21/PWC118/#task-2-adventure-of-knight


use strict;
use warnings;
use PDL;
use PDL::NiceSlice;
use Exporter::Renaming; # Avoid name conflicts with PDL
use List::Util Renaming=>[reduce=>'lu_reduce', pairs=>undef, first=>undef];
use v5.12;

my $N=8;
my $N2=$N*$N;

sub positions_from_names {
    map { my $s=zeroes($N,$N); $s->($_->[0], $_->[1]).=1; $s}
        pairs coords_from_names(@_);
}
sub names_from_positions {
    names_from_coords(coords_from_positions(@_));
}
sub names_from_coords {
    map {my ($x,$y)=@$_; $x=chr($x+ord('a')); $y=$N-$y; "$x$y"} pairs @_;
}
sub coords_from_names {
    my @coords=map {my ($x,$y)=split ''; $x=ord(lc $x)-ord('a'); $y=$N-$y; ($x, $y)} @_;
    return @coords;
}
sub coords_from_positions { # assume only one position per element
    map {$_->whichND->(:,(0))->dog} @_;
}

my $matrix=adjacency();
sub adjacency { #Build adjacency matrix for knight
    my $identity=identity($N2)->reshape($N,$N,$N,$N);# col,row,col',row'
    # Possible south going movements of the knight
    # North going movements are the transpose of south going.
    my $SEE=$identity->rotate(2) # two steps to the east
             ->mv(1,0)->rotate(1)->mv(0,1) # one step to the south
	     ->sever; # disconnect this pdl from $identity
    $SEE(0:1,:).=0;   # zero out unreachable rows and columns.
    $SEE(:,0).=0;     # Comment out for toroidal boards
    my $SSE=$identity->rotate(1)->mv(1,0)->rotate(2)->mv(0,1)->sever;
    $SSE(0,:).=0;
    $SSE(:,0:1).=0;
    my $SWW=$identity->rotate(-2)->mv(1,0)->rotate(1)->mv(0,1)->sever;
    $SWW(-2:-1,:).=0;
    $SWW(:,0).=0;
    my $SSW=$identity->rotate(-1)->mv(1,0)->rotate(2)->mv(0,1)->sever;
    $SSW(-1,:).=0;
    $SSW(:,0:1).=0;
    my $adjacency=lu_reduce {$a|$b} map {$_|$_->transpose}
    map {$_->reshape($N2,$N2)} ($SEE, $SSE, $SWW, $SSW);
    return $adjacency;
}

sub forward {
    my ($current, $end)=@_;
    my @forward=($current);
    while(all(!(($current!=0)&($end!=0)))){
	$current=(($matrix x ($current->copy->reshape(1,$N2)))->reshape($N,$N))!=0;
	push @forward, $current;
    }
    return @forward;
}
sub backward {
    my ($current,@forward)=@_;
    my @reverse=($current);
    pop @forward;
    foreach(reverse @forward){
	my $next=(($matrix x $current->copy->reshape(1,$N2))->reshape($N,$N)!=0) & ($_!=0);
	my $index=whichND($next);
	$current=$next->zeroes;
	$current->indexND($index(:,0)).=1;
	unshift @reverse, $current;
    }
    return @reverse;
}
sub path {
    my($start, @target)=@_;
    my $target=lu_reduce {$a|$b} @target; # all targets in one vector
    my @forward=forward($start, $target);
    my $reached_all=$forward[-1]&$target;
    my $reached_one=first {($_&$reached_all)->any} @target; #choose one
    my @backward=backward($reached_one, @forward); #and back-propagate
    return @backward;
}

my ($start, @treasures)=positions_from_names(@ARGV);
my @path=($start);
while(@treasures){
    my @leg=path($path[-1], @treasures);
    splice @path,-1,1,@leg;
    my $last=$path[-1];
    @treasures=grep {($_!=$last)->any} @treasures; # consume treasure
}
say "Path: ", join " ", names_from_positions(@path);
say "Visited sites: ", lu_reduce {$a|$b} @path;
say "Sequence of positions:\n", @path;
