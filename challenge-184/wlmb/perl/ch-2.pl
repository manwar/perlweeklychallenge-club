#!/usr/bin/env perl
# Perl weekly challenge 184
# Task 2:  Split Array
#
# See https://wlmb.github.io/2022/09/26/PWC184/#task-2-split-array
use v5.36;
use experimental qw(for_list);
use List::Util qw(reduce);

sub arr2str(@X){ # recursively converts array to string
    "[" . join(", ", map{ref $_ eq "ARRAY"? arr2str(@$_):$_} @X) . "]"
}

die <<EOF unless @ARGV;
Usage: $0 S1 [S2...]
to split strings S1, S2... into arrays of numbers and letters.
Each string should contain space separated single letters a-z and/or digits 0-9.
EOF
for(@ARGV){ # check arguments
    die "Wrong format: $_" unless /^[a-z0-9](\s+[a-z0-9])*$/;
}

my (@numbers_arr, @letters_arr); # arrays of array refs
for my ($numbers,$letters)( # array refs
    map { # separate each arg into number and letters array refs.
        my(@numbers, @letters);
        /^[0-9]$/ and push @numbers, $_ or push @letters, $_ for split " ";
	[@numbers], [@letters]
   } @ARGV
) {
   push @numbers_arr, $numbers if @$numbers; # ignore empty arrays
   push @letters_arr, $letters if @$letters;
}
say arr2str(@numbers_arr), " and ", arr2str(@letters_arr);
