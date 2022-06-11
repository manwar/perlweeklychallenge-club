#!/usr/bin/env perl6
#
#
#       numbrs-without-th-lttr-.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

my @ones  = < ∅ one two three four five six seven eight nine >;
my @tens  = < ∅ ten twenty thirty forty fifty sixty seventy eighty ninety >;
my %teens = <   ten-one     eleven 
                ten-two     twelve 
                ten-three   thirteen 
                ten-four    fourteen 
                ten-five    fifteen 
                ten-six     sixteen 
                ten-seven   seventeen 
                ten-eight   eighteen 
                ten-nine    nineteen >;


my @out = ([X] @tens, @ones).map: *.join('-');

for @out {
    s:g/ ^ \∅\- | \-?\∅ $ //;
    s/ $_ /%teens{$_}/ if %teens{$_}:exists;
}
@out.shift;

.say for @out.grep:{ ! /e/ };



