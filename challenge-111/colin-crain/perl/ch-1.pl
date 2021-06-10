#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       are-we-in.pl
#
#       Search Matrix
#         Submitted by: Mohammad S Anwar
#         You are given 5x5 matrix filled with integers such that each row is
#         sorted from left to right and the first integer of each row is greater
#         than the last integer of the previous row.
# 
#         Write a script to find a given integer in the matrix using an
#         efficient search algorithm.
# 
#         Example
# 
#             Matrix: [  1,  2,  3,  5,  7 ]
#                     [  9, 11, 15, 19, 20 ]
#                     [ 23, 24, 25, 29, 31 ]
#                     [ 32, 33, 39, 40, 42 ]
#                     [ 45, 47, 48, 49, 50 ]
# 
#             Input:  35
#             Output: 0     since it is missing in the matrix
# 
#             Input:  39
#             Output: 1     as it exists in the matrix
# 
#         method: 
#             we have two nested, sorted datasets. We need to first locate the
#             correct row that the value may be located in, then search the row
#             iteslf to look for a matching element. "Efficiency" becomes a
#             somewhat difficult to interpret term when sorting a through 25
#             values, as literally any method is likely to be lightning fast.
#             The overhead for the conditionals in implementing a binary search,
#             for example, would probably add more operations than saved, over
#             time.
# 
#             As it's unclear exactly where the line of simplicity versus
#             optimized searching is going to fall, we're going to set up a
#             variety of methods and see what works best. As the task was quite
#             clear that we will be working with a set 5×5 matrix we will tune
#             especially for that, rather than a more general-purpose solution.
#             
#         solutions:
#             1. flatten the matrix and look inside. The first version used
#             `List::Util::any()` to look through the array because it sounded
#             fast and the docs promnised it would short-circuit as soon as it
#             found a match. The docs said because of this it could replace
#             `grep`. `grep` turned out to be significantly faster. Perl is a
#             well-tuned machine.
# 
#             2. move listwise through the rows until our value is below the
#             last element, starting from row 0. This method definitively
#             identifies the value as belonging within a specific row, which can
#             then be searched. As with the previous example, I started with
#             `any`, then sped things up significantly using `grep`. As there
#             are only 5 values, I tried unwinding the `grep` into a cascading
#             conditional, and got another 10% speed boost.
# 
#             3. I tried a very simple divide-and-conquer algorithm, starting at
#             the middle row and moving either up or down from there. I hit on
#             using the spaceship operator from `sort`, figuring it would be a
#             strong target for optimization. By summing the operations of
#             comparing the target value to the first and last elements of the
#             middle array, one of the 5 values {-2,-1,0,1,2} will be produced.
#             The 2 and -2 results mean the selected row is either completely
#             above or below the target value, and a 0 means the value is above
#             the lower bound and below the upper — the value is within the row.
#             Conveniently, the only way to produce a 1 or -1 value is to have a
#             match with either the upper or lower bound element, allowing us to
#             return true immediately as we don't need to know which. The
#             conditionals are aranged to fall through, and should they arrive
#             at the bottom there are only 3 possible remaining positions that
#             may match, and these are enumerated with their own conditionals.
# 
#             One problem was that should a value lie above one row but below
#             the next an oscellating state is set up where we move between
#             checking two rows as the position of the value lies between them.
#             We need an additional conditional to check for this.
# 
#             Despite stripping the control structures and computation to a
#             minimum I could not get this technique to overtake the simple
#             row-wise search.
# 
#             4. In a last effort to unseat the throne I came up with the
#             simplest way to divide the row search that I could, with the
#             smallest amount of extra code. This method starts at the third
#             row, then moves the seleted row either upwards or downwards from
#             there. The search within the row remains the same.
# 
#             Although this method will locate the correct row in an average
#             of 2.2 tries, an improvement of the 3 tried of the original, it
#             ends up running about 10% slower. 
#             
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

our $mat = [  [  1,  2,  3,  5,  7 ],
              [  9, 11, 15, 19, 20 ],
              [ 23, 24, 25, 29, 31 ],
              [ 32, 33, 39, 40, 42 ],
              [ 45, 47, 48, 49, 50 ]  ];



sub search_flattened ( $val) {                              ## [1]
    return (grep {$_ == $val} map {$_->@*} $mat->@*) || '0';
}


sub search_rows ( $val, $row = 0) {                         ## [2]            
    return 0 if $val > $mat->[-1]->[-1];
    
    $row++ while ($val > $mat->[$row]->[-1]);
    
    return 1 if (    $val == $mat->[$row]->[0] 
                  || $val == $mat->[$row]->[1] 
                  || $val == $mat->[$row]->[2] 
                  || $val == $mat->[$row]->[3] 
                  || $val == $mat->[$row]->[4] );
    return 0;
}


sub search_divide ( $val, $row = 2) {                       ## [3]
    while (1) {
        $_ = ($val <=> $mat->[$row]->[0]) + ($val <=> $mat->[$row]->[-1]);
        if ($_ == -2) {
            return 0 if ($row == 0) or ($val > $mat->[$row-1]->[-1]);
            $row--;
        }
        elsif ($_ == 2) {
            return 0 if ($row == $mat->$#*) or ($val < $mat->[$row+1]->[0]);
            $row++;
        }
        elsif ($_) {
            return 1;
        }
        else {
            return 1 if (   $val == $mat->[$row]->[1] 
                         || $val == $mat->[$row]->[2] 
                         || $val == $mat->[$row]->[3] );
            return 0;
        }
    }
}

sub search_rows_mid ( $val, $row = 2) {                     ## [4]
    return 0 if $val > $mat->[-1]->[-1] or $val < $mat->[0]->[0] ;
    
    $row-- while ($val < $mat->[$row]->[0]);
    $row++ while ($val > $mat->[$row]->[-1]);
    
    return 1 if (    $val == $mat->[$row]->[0] 
                  || $val == $mat->[$row]->[1] 
                  || $val == $mat->[$row]->[2] 
                  || $val == $mat->[$row]->[3] 
                  || $val == $mat->[$row]->[4] );
    return 0;
}




use Test::More;

is search_rows(35), 0, 'ex-1-rows';
is search_rows(39), 1, 'ex-2-rows';

is search_rows_mid(35), 0, 'ex-1-rows-mid';
is search_rows_mid(39), 1, 'ex-2-rows-mid';

is search_flattened(35), 0, 'ex-1-flat';
is search_flattened(39), 1, 'ex-1-flat';

is search_divide(35), 0, 'ex-1-divide';
is search_divide(39), 1, 'ex-2-divide';

is search_rows(22), 0, 'between-rows-rows';
is search_rows_mid(22), 0, 'between-rows-rows-mid';
is search_flattened(22),   0, 'between-rows-flat';
is search_divide(22),      0, 'between-rows-divide';

is search_rows(51), 0, 'above-top-rows';
is search_rows_mid(51), 0, 'above-top-rows-mid';
is search_flattened(51),   0, 'above-top-flat';
is search_divide(51),      0, 'above-top-divide';

is search_rows(0), 0, 'below-bot-rows';
is search_rows_mid(0), 0, 'below-bot-rows-mid';
is search_flattened(0),   0, 'below-bot-flat';
is search_divide(0),      0, 'below-bot-divide';

is search_rows(-1), 0, 'negative-rows';
is search_rows_mid(-1), 0, 'negative-rows-mid';
is search_flattened(-1),   0, 'negative-flat';
is search_divide(-1),      0, 'negative-divide';

is search_rows(1), 1, 'row1-rows';
is search_rows_mid(1), 1, 'row1-rows-mid';
is search_flattened(1),   1, 'row1-flat';
is search_divide(1),      1, 'row1-divide';

is search_rows(50), 1, 'row5-rows';
is search_rows_mid(50), 1, 'row5-rows-mid';
is search_flattened(50),   1, 'row5-flat';
is search_divide(50),      1, 'row5-divide';

use Benchmark qw( cmpthese );

cmpthese(-3, {
'row'     => sub { search_rows($_) foreach 0..51; },
'row-mid' => sub { search_rows_mid($_) foreach 0..51; },
'flat'    => sub { search_flattened($_) foreach 0..51; },
'div'     => sub { search_divide($_) foreach 0..51; },

});

done_testing();

=cut

           Rate    flat     div row-mid     row
flat    13657/s      --    -59%    -68%    -71%
div     33533/s    146%      --    -21%    -29%
row-mid 42575/s    212%     27%      --    -10%
row     47312/s    246%     41%     11%      --

the best way to efficiency is to not execute code
