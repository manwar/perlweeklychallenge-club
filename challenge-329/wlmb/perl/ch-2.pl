#!/usr/bin/env perl
# Perl weekly challenge 329
# Task 2:  Nice String
#
# See https://wlmb.github.io/2025/07/07/PWC329/#task-2-nice-string
use v5.36;
use List::UtilsBy qw(max_by);
say "$_ -> ",max_by {length} /(.+)(??{nice($1)?"(*ACCEPT)":"(*FAIL)"})/g for @ARGV;
sub nice($s){
    for($s){ # set the topic
	while(1){
	    return 1 if /^$/;               # null strings are nice
	    /^(.)(.*)/;                     # capture first character and rest
	    my ($lc, $UC)=(lc($1), uc($1));
	    return 0 unless /$lc/ && /$UC/; # check both cases are present in string
	    s/$lc|$UC//g;                   # remove already tested letters
	}
    }
}
