#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       triangular-sum-ting.pl
#
#       Summations
#         Submitted by: Mohammad S Anwar
#         You are given a list of positive numbers, @n.
# 
#         Write a script to find out the summations as described below.
# 
#         Example 1
# 
#             Input: @n = (1, 2, 3, 4, 5)
#             Output: 42
#     
#                 1 2 3  4  5
#                   2 5  9 14
#                     5 14 28
#                       14 42
#                          42
# 
#         The nth Row starts with the second element of the (n-1)th row.
#         The following element is sum of all elements except first element
#         of previous row. You stop once you have just one element in the
#         row.
# 
#         Example 2
# 
#             Input: @n = (1, 3, 5, 7, 9)
#             Output: 70
#     
#                 1 3  5  7  9
#                   3  8 15 24
#                      8 23 47
#                        23 70
#                           70

#         opening commentary:
# 
#             Behold another piece of unusual operation assemblage,
#             systematically reducing a list according to the rules of an
#             arcane process. Again I can't immediately see a rationale for
#             doing this particular task, but that's no mind. 


#         method:
#             
#             Let's break it down. At each iteration, we:
#                 1. shift off the first value from the list
#                 2. incrementally sum the list from left to right
#                 3. at each position, add the running total to a new list
#                 4. after filling the last postion, replace the old list with the new 
#                 5. repeat until there is only once value in the new list
#                 
#             Well when you put it like that, it doesn't seem so bad.
#
#       © 2022 colin 
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use constant {VERBOSE => 1};
our @stack;

say trisum( @ARGV ) and exit if @ARGV ;

sub trisum (@list) {
    my $sum;
    my @new;
    @stack = [@list];

    while (@list > 1) {
        @new = ();
        $sum = 0;
        
        shift @list;
        for (keys @list) {
            $sum += $list[$_];
            push @new, $sum;
        }
        push @stack, [@new];
        @list = @new;
    }
    print_stack_and_flush() if VERBOSE;

    return shift @new;
}


sub print_stack_and_flush {
    my $elements   = @stack;
    my $max_digits = length $stack[-1]->[0];
    my $fmt = ('%' . ($max_digits + 3) . 's') x $elements;

    say "\ntrianglular reduction steps:\n";
    
    for my $row (@stack) {
        unshift $row->@*, '' while $row->@* < $elements;
        say sprintf $fmt, $row->@*;
    }
    
    say "sum  $stack[-1]->[-1]\n";
    
    @stack = ();
}







use Test::More;

is trisum(1, 2, 3, 4, 5), 42, 'ex-1';
is trisum(1, 3, 5, 7, 9), 70, 'ex-2';

done_testing();
