#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       crossing-the-stream.pl
#
#       Average of Stream
#         Submitted by: Mohammad S Anwar
#         You are given a stream of numbers, @N.
# 
#         Write a script to print the average of the stream at every point.
# 
#         Example
#             Input: @N = (10, 20, 30, 40, 50, 60, 70, 80, 90, ...)
#             Output:      10, 15, 20, 25, 30, 35, 40, 45, 50, ...
#     
#                 Average of first number is 10.
#                 Average of first 2 numbers (10+20)/2 = 15
#                 Average of first 3 numbers (10+20+30)/3 = 20
#                 Average of first 4 numbers (10+20+30+40)/4 = 25 and so on.
#
#         method:
#             Rather than maintain a separate count of the values summed to
#             create an average, we already have this value as we're always
#             counting elements fron the first index. 
# 
#             By calling `each` on the `@stream` array we get tuples of index
#             and value for each element. We establish a running `$sum` value
#             that is kept up-to-date with even new element, dividing this by
#             `$idx`, which always contains one less than the number of elements
#             summed will give us an average value of everything seen up to that
#             point from index 0. 
#         
#         
#         
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



my @stream = (10, 20, 30, 40, 50, 60, 70, 80, 90);

my $sum = 0;
while ( my ($idx, $val) = each @stream ) {
    $sum += $val;
    $_ = sprintf "%.2f", $sum / ($idx+1);
    s/\.0*$//;
    say "average of first ", $idx+1, " numbers is ", $_;
}
