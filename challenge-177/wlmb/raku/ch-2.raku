#!/usr/bin/env raku
# Perl weekly challenge 177
# Task 2: Palyndromic prime cyclops
#
# See https://wlmb.github.io/2022/08/08/PWC177/#task-2-palindromic-prime-cyclops
my $left=1;
my $count=0;
my $how_many=@*ARGS[0]//20;
while $count < $how_many {
    my $candidate=$left~0~$left.flip;
    if !($left ~~ /0/) && is-prime($candidate) {
        ++$count;
	"$candidate ".print;
    }
    ++$left;
}
"".say;
