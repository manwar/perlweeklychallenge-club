#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       recalc.pl
#
#       Calculator
#         Submitted by: Mohammad S Anwar
#         You are given a string, $s, containing mathematical expression.
# 
#         Write a script to print the result of the mathematical
#         expression. To keep it simple, please only accept + - * ().
# 
#         Example 1:
# 
#             Input: $s = "10 + 20 - 5"
#             Output: 25
# 
#         Example 2:
# 
#             Input: $s = "(10 + 20 - 5) * 2"
#             Output: 50
# 
#         method:
#             Mathematical expressions are guided by the rules of precedence. Operations 
#             occur left=-to-right, with parenthetical sub-expressions evaluated first, 
#             then exponents,
#             then multiplication and division, then addition and subtraction. 
#             
#             The puzzle here, then, is one of getting the order right. The hard part, the 
#             way I see it, is implementing evaluating sub-expressions first, specifically 
#             nested sub-expressions. We need to select out the innermost nested pair of delimiters 
#             and produce a value, where the idea of innermost is initially unknown.
#             
#             The general approach that lends itself to problems where we want to perform an
#             action some unknown number of times to home in on a result is to use 
#             recursion.
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub evaluate( $expr ) { 
    $expr =~ s/ \( \s* ([^(]*) \s* \) / evaluate($1) /exg ;
    do {1} while $expr =~ s/ ([\d.-]+) \s* \* \s* ([\d.-]+) / $1 * $2 /ex ;
    do {1} while $expr =~ s/ ([\d.-]+ \s* [+-] \s* [\d.-]+) / $1 /eex ;
    $expr =~ s/\A\s*|\s*\Z//g;
    return $expr;
}















use Test::More;

is evaluate( "10 + 20 - 5" ), 25, 'ex-1';
is evaluate( "(10 + 20 - 5) * 2" ), 50, 'ex-2';
is evaluate( "(10.5 + 2) * 2 " ), 25, 'decimal';

done_testing();
