#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       well-aint-that-special.pl
#
#       Special Integers
#         Submitted by: Mohammad S Anwar
#         You are given a positive integer, $n > 0.
# 
#         Write a script to print the count of all special integers between
#         1 and $n.
# 
#         An integer is special when all of its digits are unique.
# 
#         Example 1:
#             Input: $n = 15
#             Output: 14 as except 11 all other integers between 1 and 15 are special.
#  
#         Example 2:
#             Input: $n = 35
#             Output: 32 as except 11, 22, 33 all others are special.

#         Analysis:
# 
#         A written number is a not exactly a number, really, but rather a
#         representation of an abstract concept in a certain specified
#         manner. It is certainly one way to look at a number, but doesn't
#         capture the totality. It is a shadow, describing an outline from
#         a particular point of view.
# 
#         The chosen manner here is as a decimal expansion, with symbol
#         placement indicating multiplication by increasing powers of ten.
#         We are looking, then, at written lines of glyphs. Forget about
#         numbers for now. Digits are characters, and so we're looking for
#         certain strings where every character is different. 

#         I think it reasonable to say that viewed mathematically the idea is
#         quite complex. There are no consistent relationships between the
#         various numerical values for the digits. 
# 
#         Fortunately we don't really care about the strings as numbers, up
#         until the string, viewed as a number, exceeds the given maximum
#         limit, which is about the only easy numerical quality we can
#         check.

#         A brute-foce approach would be to check increasing numbers,
#         moving on when a duplicate digit is detected withing a number and
#         compiling a list of all that pass the test. Needless to say this
#         will become very slow with larger numbers, and as we have ten
#         digits available we will have new special numbers up to a hard
#         limit of 11 digits. Per the definition then, the largest number
#         will have the largest digits in the largest positions, and we
#         conclude that limit ot be 9,876,543,210. Counting through that
#         last nine billion will be quite tedious. 

#         Alternately, we could save some time and construct only special
#         numbers, growing our list by adding unique digits to existing
#         numbers until we reach out given target. This will in turn
#         require some means of making sure we keep the newly added numbers
#         unique, requiring us to keep track of the state of the system,
#         either continuously throughout or on-demand. 

#         A good way to construct arrangements according to a fixed set of
#         incidence rules is to start with a bag of all pemissible elements
#         and remove elements from play as they are used. In this case if
#         we have a bag containing the digits 0 through 9 as physical
#         chits, we remove one and are assured we cannot draw that one
#         again. Using such a bag we can construct any special number.
# 
#         But how do we do that? Well, we could model the act of drawing
#         out a physical chit using a hash table and recursion: with the
#         digits stored as keys in a hash, when we use a digit we can
#         delete that key from the table and pass the altered table into
#         the next cycle of recursion.
# 
#         There's a bunch of hairy edges to this model, however. We will
#         need a large number of separate copies of the table for each
#         go-around, but I think with the small size of the table this
#         might be ok. We can make a new longer number using each of the
#         remaining available digits for each number of the current longest
#         length, but need to keep the shorter numbers intact at the same
#         time, requiring tow pools, on efor completed numbers an one for
#         numbers being worked on and available to be lengthened. And we
#         will also need to determine when we can stop recursing.
# 
#         All this is kind of unnecessarily complicated, if you ask me.
#         WHat we reall need is just a simple loop, adding digits one at a
#         time. We keep two pools, constucting new numbers from one and
#         then dumping them into the other, of final results, at the end of
#         every loop.
# 
#         And keeping a billion bags around probably isn't exactly healthy.
#         Alternately if we know there are only 10 possible options at
#         most, why not check each of them, but only for exending existing
#         special numbers? As the numbers are a limited subset this will
#         substantically reduce the size of the search space, and a few
#         quick checks will probably outweigh the cost of creating all
#         those bags. Much less confusing, too.
# 
#         That seems streamlined and more promising.
# 
#         If we take this route we will need a way to quicky check a digit
#         candidate against the existing digits in a number.
# 
#         Again with the bags — I must have bags on the mind — we can make
#         a bag of digits from an existing number with a single line of
#         code:
# 
#             my %digits = map { $_, undef } split '', $num;
# 
#         Then we can check to see whether a key for a digit is there using
#         `exists`. This sounds pretty quick. Long story short, it can
#         calculate every special number in under five minutes on my
#         machine:
# 
#             $  time perl 195-2-well-aint-that-special.pl 10000000000
#             8877690
# 
#             real	4m44.287s
#             user	4m42.589s
#             sys	0m1.008s
#         
#         But wait! That is probably good enough, as it's a hard upper
#         limit on the  special numbers that exist. There simply can't be
#         any more. But again we are still making tem billion hashes or so,
#         even if we aren't keeping them around. At the risk of premature
#         optimization we can probably do better. 
#         
#         We could, for instance, maybe do a regular expression. Tem billion
#         times, give or take. 

#         Hmmm... 

#         The regular experession engine is an artful piece of
#         architecture, but also non-trivial. As Neal Stephenson might say,
#         it has *infrastructure*. Yes this will work wonderfully and does
#         its magic quite clearly, but still is like sending your car back
#         to the factory to swap out all the the wheels when all you need
#         is some air in a tire. It's a lot of tool for the job. The
#         analogy of a factory, in fact, is pretty on-point. 

#         It is, we should note, still faster than making bags, by a
#         significant factor. 
#         
#         There is however a third way that will change the game, in the
#         form of the built-in Perl `index` function. Given parameters,
#         this searches a string for a substring, looking from left to
#         right in a single pass, and in doing so avoids almost all of the
#         complexity of the general-purpose regex engine. The result then,
#         is lightning fast, as it does exactly what we want and absolutely
#         nothing more, minimizing extra overhead.  

#         Recrafting our vwerification subroutine using `index`, we get an
#         approximately 11-fold increase in efficiency: 

#             $  time perl 195-2-well-aint-that-special.pl 10000000000
#             8877690
# 
#             real	0m25.693s
#             user	0m25.230s
#             sys	0m0.429s

#         Now — that — I will declare to be good enough. 

        
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


my  $input = shift @ARGV // 10_000_000_000;          

my  $count =  make_special( $input );
say $count;

sub make_special ( $max ) {
    my @results = grep { $_ < $max } (1..9);
    my @prev    = @results; 
    my @next;
    for (1..length $max) {
        @next = ();
        for my $base_num ( @prev ) {
            for (0..9) {
                push @next, $base_num . $_ if allowed_index( $max, $base_num, $_ );
            }
        }
        push @results, @next;
        @prev = @next;
    }
    return @results;
}

## 100_000_000 ~ 1m05s
sub allowed_bag ( $max, $num, $new ) {
    my %digits = map { $_, undef } split '', $num;
    return 0 if exists $digits{$new};
    return 0 if "$num$new" > $max;
    return 1;
}

## 100_000_000 ~ 43s
sub allowed_regex ( $max, $num, $new ) {
    return 0 if $num =~ /$new/;
    return 0 if "$num$new" > $max;
    return 1;
}

## 100_000_000 ~ 6s
sub allowed_index ( $max, $num, $new ) {
    return 0 if index($num, $new) > -1;
    return 0 if "$num$new" > $max;
    return 1;
}

