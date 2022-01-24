#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       numbrs-without-th-lttr-.pl
#
#         Eban Numbers
#         Submitted by: Mohammad S Anwar
#         Write a script to generate all Eban Numbers <= 100.
# 
#         An Eban number is a number that has no letter ‘e’ in it when the
#         number is spelled in English (American or British).
# 
#         Example
# 
#             2, 4, 6, 30, 32 are the first 5 Eban numbers.
# 
#       method: 
#             I think we're finally jumped the shark on number theory,
#             landing with a splash right in the middle of natural language
#             programming.
# 
#             It's tempting to try and write a textual conversion routine to
#             "speak" all two-digit numbers. On the other hand, it's much
#             more sensible to use Neil Bower's excellent Lingua::EN::Numbers
#             to do the tricky part for us. It is:
#                 1. the right way to do it
#                 2. good practice in the right way to do it
# 
#             Addressing the first point: Natural Language Programming is
#             fraught with hairy little edge-cases that need to be
#             addressed, and so, keeping company with the CSV format and
#             Date and Time Manipulation code, it's wise to hand over such
#             processing to a dedicated library that's sole purpose is to
#             keep such stuff straight.
# 
#             Then again it wouldn't be too crazy to address every case.
#             It's easy to visually inspect them all. It is, after all,
#             only 99 numbers if we start from 1. Why 1? As for zero, well just look at
#             it. And all negative numbers contain the letter "e" in the
#             word "negative" so we don't even need to decide to only use
#             positive values. On the other hand there are an infinite
#             number of real values below 100, so we'll need to disallow
#             that unwholesome creed if we ever want to finish:
#             "thirty-four point six six six six six ..."
# 
#             Yea that's not going to work.
# 
#             We'll start with implementing the module and go from there.
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

## this is the right way to do this
use Lingua::EN::Numbers qw( num2en );
for (0..99) {
    my $word = num2en( $_ );
    next if $word =~ /e/;
    say $word;
}

say '';  ## separate out two methods

## constructing written words for numbers less than 100 is a irregular and non-obvious.
my @ones  = qw( ∅ one two three four five six seven eight nine );
my @tens  = qw( ∅ ten twenty thirty forty fifty sixty seventy eighty ninety);
my %teens = qw( ten-one     eleven 
                ten-two     twelve 
                ten-three   thirteen 
                ten-four    fourteen 
                ten-five    fifteen 
                ten-six     sixteen 
                ten-seven   seventeen 
                ten-eight   eighteen 
                ten-nine    nineteen );
                
my @out;
for my $t ( @tens ) {
    for my $o ( @ones ) {
        push @out, "$t-$o";
    }
}

for (@out) {
    s/^∅-|-?∅$//g;
    s/$_/$teens{$_}/ if $teens{$_};
}

shift @out;
say $_ for grep { ! /e/ } @out;












# use Test::More;
# 
# is 
# 
# done_testing();
