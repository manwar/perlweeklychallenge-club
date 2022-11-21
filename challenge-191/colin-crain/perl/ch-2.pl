#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       cutesy.pl
#
#       Cute List
#         Submitted by: Mohammad S Anwar
#         You are given an integer, 0 < $n <= 15.
# 
#         Write a script to find the number of orderings of numbers that
#         form a cute list.
# 
#         With an input @list = (1, 2, 3, .. $n) for positive integer $n,
#         an ordering of @list is cute if for every entry, indexed with a
#         base of 1, either
# 
#         1) $list[$i] is evenly divisible by $i
# 
#         or
# 
#         2) $i is evenly divisible by $list[$i]
# 
#         Example

#             Input: $n = 2 
#             Ouput: 2
# 
#             Since $n = 2, the list can be made up of two integers only
#             i.e. 1 and 2. Therefore we can have two list i.e. (1,2) and
#             (2,1).
# 
#             @list = (1,2) is cute since $list[1] = 1 is divisible by 1
#             and $list[2] = 2 is divisible by 2.

#         analysis:
# 
#             Ok, this is a little confusing, I must say. Let's start by
#             rephrasing the description to help us figure out what we need
#             to do here.
# 
#             First, our data. We are fed a single value *n*. From this we
#             can derive a list, which is further processed.
# 
#             Our given list in play is comoposed of *n* elements, starting
#             with the value 1 and incrementing by 1 until we reach *n*. 
#             Hence, given the value *n* as input we construct the list (1,
#             2, 3, 4, ... n ) to work with.
# 
#             A "cute" list is a specific rearrangement of this list such
#             that the elements each conform to one of two rules. We will
#             assume that validation by both rules would also be
#             acceptable. 
# 
#             The rules are, for each element at index *i*, indexed
#             starting at 1, either: 
#                 1. the value at i     is divisible by     the index i, or
#                 2. the index i        is divisible by     the value at i
# 
#             These two relationships share a similar problem-space but
#             appear at first to be unrelated. A list where eachg member
#             satisfies at least one condition could well be called "cute",
#             but the conditions are not ultimately meaningful, albeit
#             nicely symmetrical.
# 
#             But we aren't done! What we're doing is not making cute
#             lists, but rather *counting* cute lists. So we need to not
#             only find a solution, but find a method for finding every
#             solution so we can count them. Perhaps a larger pattern will
#             emerge, drawn from linkages between the problem spaces of the
#             two conditions. 
# 
#             For smaller numbers of n, we can simply permute the lists,
#             and check each value for qualfying in either one case or the
#             other. We can simplify things by setting the array base index
#             to 1 and using `keys` to iterate the indices. To do this will
#             need to import the Array::Base module, as `$[` is depricated
#             and the core `arybase` module has been phased out.
# 
#             A couple of observations come right off the bat. First is
#             that the unchanged list is always cute, as when the indices
#             and their values align the index will always be divisible by
#             the value there, satisfying condition number two.
# 
#             Secondly, if we swap the head and tail index values then the
#             first index 1 will always divide any number evenly, and hence
#             satisfy condition number one. The last index will now contain
#             the value 1, and hence will still satisfy condition number
#             two as it will divide any index. The rest of the list,
#             unchanged, will remain cute. So all base sequences with 2 or more
#             elements to swap will start with two cute varieties. 

#             Unfortunately after about n = 12, things start to get messy
#             with the factorial growth of the permutation count, but
#             starting this way does give us something to work with to look
#             for a larger pattern. 

#             Of note there are a few things we can do to speed up our
#             first attempt: one, that clever modern use of `keys` uses a
#             function call to generate a list we already know the values
#             for, so it's terribly wasteful. Substituting the known
#             sequence itself cuts the computational time about in half.
#             Secondly, it seems to be fractionally faster to check the second
#             condition first and short-circuit out earlier; this provides
#             a tiny further bump in efficiency. 
# 
#             However looking at the lists of lists produced does give us
#             some insight as to the qualities of each postion in a cute
#             ordering, and some of the allowable values at each position
#             are quite limited. In the first position, for instance, there
#             are only two: 1 and *n*. So we don't need to ever even
#             compute any arrangement that does not start with one of these
#             values. Looking at the the other positions leads us to a
#             generalization:
# 
#             The set of permissible values at each position is the union
#             of all multiples of the index less than or equal to *n* (by
#             rule 1) and all divisors of the index (by rule 2). Not every
#             possible premitted value will be found in a cute list, but
#             this still drastically limits the choices. 
#             
#             For n = 12, these look like:
#             
#             i   |   permissible values               |  number of values
#             ----+------------------------------------+------------------
#             1   |   1 .. 12                             12
#             2   |   1   2   4   6   8   10  12          7
#             3   |   1   3   6   9   12                  5
#             4   |   1   2   4   8   12                  5
#             5   |   1   5   10                          3
#             6   |   1   2   3   6   12                  5
#             7   |   1   7                               2
#             8   |   1   2   4   8                       4
#             9   |   1   3   9                           4
#             10  |   1   2   5   10                      4
#             11  |   1   11                              2
#             12  |   1   2   3   4   6   12              6
#             
#             Multiplying this out reveals there are 6,451,200 combinations
#             of permissible values available, versus all 12!, or
#             479,001,600 permutations of the sequence.
# 
#             If we compute every combination and then check for *n* unique
#             members this should be considerably less computationally
#             expensive. If we got further and continuously cull the search
#             space by only adding new values that are not already used the
#             number of cute arrays in play is kept in check, and we can
#             compute to 15 and beyond without much trouble. 
# 
#             And here is is in the OEIS: 
# 
#                 A320843       Number of permutations sigma of {1,2,...,n}
#                 such that sigma(i) divides i or i divides sigma(i) for 1
#                 <= i <= n.
#             
# 
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



use Algorithm::Combinatorics qw( permutations );


my $limit = shift @ARGV // 15;

for my $n ( 1..$limit ) {
    say "n = $n"; 
    say "\t", scalar find_cute_sigma($n), " cute lists";
    
    ## uncomment to see the actual cute lists. I certainly wanted to. 
#     say "   $_->@*" for find_cute_sigma($n);

    say '';
}

## version 1: brute force. Works well up to about n = 12
##
sub find_cute ( $n ) {
    use Array::Base +1;    
    my @out;
    my $iter = permutations( [ 1 .. $n ] );
    my $p;
  ITER: while ($p = $iter->next) {
        for my $i ( 1 .. $n ) {
            next ITER if ( $i % $p->[$i] and $p->[$i] % $i );
        }
        push @out, $p;       
    }
    return @out;
}


sub get_permissible ( $pos, $max ) {
    [ grep { not $pos % $_ or not $_ % $pos } ( 1 .. $max ) ]
}

## version 2: compute all permissable digits at each position and grow
## lists from there.
##
sub find_cute_sigma ( $n ) {
    my %div;
    
    for my $pos ( 1 .. $n ) {
        $div{$pos} = get_permissible( $pos, $n );
    }

    my @out = [];
    
    ## for each position create a new array for each previous for each permissible 
    ## value, unless that value is already present in the combination
    for my $pos ( 1 .. $n ) {
        my @new;
        for my $val ( $div{$pos}->@* ) {
            for my $combi (@out) {
                unless ( grep { $_ == $val }  $combi->@* ) {
                    push @new, [ $combi->@*, $val ];
                }
            }
        }
        @out = @new;
    }
    
    return @out;
}
