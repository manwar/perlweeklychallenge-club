#!/usr/bin/env perl
# Perl weekly challenge 174
# Task 2: Permutation ranking with lexicographic order for arbitrary strings
#
# See https://wlmb.github.io/2022/07/18/PWC174/#task-2-permutation-ranking
use v5.36;
use PDL;
use PDL::NiceSlice;
use List::Util;
my $usage=<<"END";
Usage: $0 "P1 P2...Pn" R1 R2...
to obtain rank of permutation P1 P2...Pn
and the rank-Ri permutations. Note quotations.
END
say($usage), exit unless @ARGV>0;
my $size=my @permutation=split " ", my $permutation=shift;
my $uniq=List::Util::uniq @permutation;
die "Elements should be distinct" unless $uniq==$size;
my @ordered=sort {$a cmp $b} @permutation;
my %element2index = map { ($ordered[$_], $_) } (0..$size-1);
my $permuted_indices=long [@element2index{@permutation}];
my $factorials=factorials($size);
say "permutation2rank([$permutation])=", permutation2rank($permuted_indices);
say "rank2permutation([$permutation], $_)=[", join(" ",rank2permutation($_)),"]" for(@ARGV);

sub permutation2rank($permutation){ # ranks a permutation of 0...N-1
    return $factorials->inner(ranks($permutation));
}
sub ranks($permutation){
    my $cmp=$permutation(*1)>$permutation; #P_i>P_j
    $cmp->inner($cmp->xvals>=$cmp->yvals); #r_i=sum_{j>=i}(P_i>P_j)
}
sub factorials($size){
     my $f=1;
     (long [1, map {$f=$_*$f} (1..$size-1)])->(-1:0);
}
sub rank2permutation($rank){
    my @indices=map {my $index=floor($rank/$_); $rank%=$_; $index} $factorials->list;
    my @copy=@ordered;
    map {splice @copy, $_, 1} @indices;
}
