#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       consequential-secret-cuts.pl
#
#       Consecutive Arrays
#         Submitted by: Mark Anderson
#         You are given a sorted list of unique positive integers.
# 
#         Write a script to return list of arrays where the arrays are consecutive integers.
# 
#         Example 1:
#             Input:  (1, 2, 3, 6, 7, 8, 9)
#             Output: ([1, 2, 3], [6, 7, 8, 9])
#             
#         Example 2:
#             Input:  (11, 12, 14, 17, 18, 19)
#             Output: ([11, 12], [14], [17, 18, 19])
#             
#         Example 3:
#             Input:  (2, 4, 6, 8)
#             Output: ([2], [4], [6], [8])
#             
#         Example 4:
#             Input:  (1, 2, 3, 4, 5)
#             Output: ([1, 2, 3, 4, 5])
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub consequential ( @input ) {
    my @out;
    my $subarray = [ shift @input ];
    for (@input) {
        $_ == $subarray->[-1] + 1 
            ? push $subarray->@*, $_
            : do {
                push @out, $subarray;
                $subarray = [ $_ ];
              }
    }
    return @out, $subarray;
}


my @tests = (   [1, 2, 3, 6, 7, 8, 9],
                [11, 12, 14, 17, 18, 19],
                [2, 4, 6, 8],
                [1, 2, 3, 4, 5]   );
local $" = ', ';
                
for (@tests) {
    my $input  = '(' . (join ', ', $_->@*) . ')';
    my $output = '(' . (join ', ', map {"[$_->@*]"} consequential( $_->@* )   ) . ')';
 
    say <<~"END";
    input  $input
    output $output
    
    END
}
