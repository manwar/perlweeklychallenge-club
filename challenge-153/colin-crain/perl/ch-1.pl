#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       facts-left-to-the-reader.pl
#
#       Left Factorials
#         Submitted by: Mohammad S Anwar
#         Write a script to compute Left Factorials of 1 to 10. Please
#         refer OEIS A003422 for more information.
# 
#         Expected Output:
#         1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114
#
#       analysis:
#             I found the meaning of the left factorial unusually elusive
#             for this task for some reason. Maybe because I wasn't fully
#             awake, and was distracted, but however I had it figured in my
#             head the answer to my confusion was, surprising no-one,
#             considerably simpler than I made out.
# 
#             Call it being unable to see the forest from the technical
#             minutia.
# 
#             In any case I will make a stab at my own descriptive
#             definition:
# 
#             The sum of all values in the sequence of factorials to the
#             left of, but not including, the value in question. So L(4) =
#             3! + 2! + 1! + 0!
# 
#             Another clver bit of nomaclature I saw was to denotate this
#             as:
# 
#             !5 = 0! + 1! + 2! + 3! + 4!
# 
#             Note the exclamation is placed tp the left for the left
#             factorial.
# 
#             0! is a funny concept that for the purposes of disucssion
#             equals 1, and is arrived at by considering the sequence as a
#             whole. 
# 
#         method:
#             To compute a list of the first ten, or whatever number, of
#             left factorials, we will need to compute factorials and
#             maintain a running sum sequence of those preceding. To keep
#             things interesting we'll input an arbitrary number request
#             for the sequence instead of fixing the request to 10.
# 
#             Things blow up quickly along the factorial number line. 
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
use bigint;

my $num   = shift // 50;

my @left  = (0,1);
my $fact  = 1;
my $count = 1;

while ($count < $num) {
    $fact *= $count;
    push @left, $left[-1] + $fact;
    $count++;
}

say for @left;







# use Test::More;
# 
# is 
# 
# done_testing();
