#!/usr/bin/env perl
# Perl weekly challenge 183
# Task 1:  Unique Array
#
# See https://wlmb.github.io/2022/09/20/PWC183/#task-1-unique-array
use v5.36;
use experimental qw(try);
use PDL;
use PDL::NiceSlice;
die <<EOF
Usage: $0 "[V1,V2...]" ...
to print the unique arrays among V1, V2...
Each V_i is an array [N1, N2...] of numbers N_j, or an array of arrays [W1,W2...] where
each Wj is an array of...
Admits multiple arguments.
EOF
unless @ARGV;
for(@ARGV){
    try {
        my $input=pdl $_;
	my $flat=$input->clump(-2);
	my $repetitions=($flat->(:,:,*1)==$flat(:,*1,:))->andover;
	my $redundant=($repetitions&($repetitions->xvals < $repetitions->yvals))->orover;
	my $keep_indices=which(!$redundant);
	say +$input->mv(-1,0)->index1d($keep_indices)->mv(0,-1);
    }
    catch ($m) {
        say "\n$m\nInvalid ndarray: $_";
    }
}
