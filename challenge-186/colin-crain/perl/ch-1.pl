#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       .pl
#
#       Zip List
#         Submitted by: Mohammad S Anwar
#         You are given two list @a and @b of same size.
# 
#         Create a subroutine sub zip(@a, @b) that merge the two list as
#         shown in the example below.
# 
#         Example
# 
#             Input:  @a = qw/1 2 3/; @b = qw/a b c/;
#             Output: zip(@a, @b) should return qw/1 a 2 b 3 c/;
#                     zip(@b, @a) should return qw/a 1 b 2 c 3/;
#
#       method
#         I've never much been a fan of Perl function prototypes. They
#         always seemed a half-measure, emphasising what they were not,
#         which is is proper subroutine signature. They added a minor
#         hassle with little practical benefit, for me at least. And
#         others too, apparently, as they never much caught on. 
        
#         When actual subroutine signatures were introduced things got a
#         little wierder, as protptypes and signatures occupy the same
#         semantic positioning. This is obviated by the :prototype keyword,
#         which must now be used should two need to coexist. Personally I
#         find this more pleasing, as it very much labels the prototypes as
#         *not* being a signature, which I always brought down the
#         readability of code using them. They're still esoteric, but at
#         least less outright confusingly. 

#         All this is to satisfy Mohammads request that we provide a zip
#         subroutine that is fed two arrays, and not array references.
#         Sneaky twist that, but we deliver noethelass.
# 
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub zip :prototype(\@@);

my @a = (1,2,3);
my @b = (4,5,6);

my @res = zip @a, @b;
say "@res";


sub zip :prototype(\@@) ($one, @two) {
    my @out;
    for ($one->@*) {
        push @out, $_, shift @two;
    }
    return @out;
}





