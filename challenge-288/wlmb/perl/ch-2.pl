#!/usr/bin/env perl
# Perl weekly challenge 288
# Task 2:  Contiguous Block
#
# See https://wlmb.github.io/2024/09/23/PWC288/#task-2-contiguous-block
use v5.36;
use experimental qw(try);
use PDL;
use PDL::NiceSlice;

sub PDL::md  :lvalue ($t) { # take diagonal i=k j=l of 4d matrix with indices ijkl
    $t->diagonal(0,2)->diagonal(1,2);
}

die <<~"FIN" unless @ARGV;
    Usage: $0 M1 M2...
    to find the size of the largest contiguous component of the matrices
    M1 M2...
    Each matrix M1 should be a string of the form [[oxxo...][xoxo...]...]
    i.e., a matrix of rows formed of cells, each of which is occupied by
    either an 'x' or an 'o'
    FIN
# Slices to shift 4d matrices ijkl along the horizontal ik or vertical jl directions.
my @slices=("1:-1,:,0:-2", "0:-2,:,1:-1","1:-1,:,1:-1", "0:-2,:,0:-2");
for(@ARGV){
    my $orig=$_;
    my $matrix;
    try {
	die("Invalid string: $_") unless /^\[\s*(\[\s*[xoXO]+\s*\]\,?)+\s*\]$/;
	s/o|O/0,/g;
	s/x|X/1,/g;
	$matrix=pdl($_);
    } catch($e) {
	warn $e;
	next;
    }
    my $connectivity=zeroes($matrix->dims, $matrix->dims);     # i,j,k,l
    map {$_->md.=$matrix(0:-2)==$matrix(1:-1)}                 # check horizontal...
        map{$connectivity("$_,:")}@slices[0,1] if($matrix->dim(0)>1);
    map {$_->md.=$matrix(:,0:-2)==$matrix(:,1:-1)}             # and vertical connections
       map{$connectivity(":,$_")}@slices[0,1]  if($matrix->dim(1)>1);
    my $dim=$matrix->nelem;
    my $connectivity_matrix=$connectivity->reshape($dim,$dim); # ij,kl
    my $occupied=zeroes(1,$dim);                               # empty column vector
    my $largest=0;                                             # size of largest cluster
    my $cluster=0;                                             # total occupied sites
    for(0..$dim-1){
	next if $occupied(0,$_);                               # skip if already occupied
	$occupied(0,$_).=1;                                    # add traveller
	while(1){
	    my $next=$occupied|(($connectivity_matrix x $occupied)!=0);
	    last if all($next==$occupied);
	    $occupied=$next;                                   # update visited sites
	}
	$cluster+=my $current=$occupied->sum-$cluster;
	$largest=$current if $current>$largest;
    }
    say "$orig -> $largest";
}
