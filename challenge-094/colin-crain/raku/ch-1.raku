#!/usr/bin/env perl6
#
#
#       grouping_anagrams.raku
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (*@input) ;

@input.elems == 0 and @input = "Opt", "bat", "saw1", "tab", "po-t", "top", "wa's";

@input .= map: { .lc; };
@input .= map: { S:g/<-[a..z]>// };

my %lets;
push %lets{ .comb.sort.join }, $_ for @input;

.say for values %lets;






