#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       .pl
#
#       Split Number
#         Submitted by: Mohammad S Anwar
#         You are given a perfect square.
# 
#         Write a script to figure out if the square root the given number
#         is same as sum of 2 or more splits of the given number.
# 
#         Example 1
#             Input: $n = 81
#             Output: 1
# 
#             Since, sqrt(81) = 8 + 1
# 
#         Example 2
#             Input: $n = 9801
#             Output: 1
# 
#             Since, sqrt(9801) = 98 + 0 + 1
# 
#         Example 3
#             Input: $n = 36
#             Output: 0
# 
#             Since, sqrt(36) != 3 + 6
# 
# 
#       method:
# 
#         "2 or more splits of the given number"
# 
#         The what of the what? Splits? What is that? I mean, I see what it
#         is. You might call it a sort of "digital partioning", with
#         sequential digits grouped in various arrangements. It's
#         mathematically curious because the positional values change for a
#         given digit depending on the segmentation. Mathematically it's
#         all very weird.
# 
#         SOmehow I doubt there's any other name for it: "splits" is as
#         good as any, but "digital partition" at least sounds like a
#         specific process, like the digital root with 50% less Voodoo. Or
#         maybe Kabbalah would be more accurate.
# 
#         In any case it all soounds very complex if we look at the groups
#         of numbers generated when multiple splitting variations are
#         available. One thing is noteworthy, however, and that is that we
#         are taking ordered sets; if different partitionings generate the
#         same set of values, and hence the same sum, from different
#         groupings of the digits, then that's just coincidence. The
#         different groupings are different partitions and that is that.
# 
#         For example take the number 361361. There are many partitions
#         available, but two of these are (36) + (1) + (3) + (6) + (1) and
#         (3) + (6) + (1) + (36) + (1) As the divisions lie in different
#         places, they would be different partitions, or slices. As they
#         sum to the same value this makes no difference for this task. The
#         task asks only whether such a matching digital partition exists,
#         not what it is.
# 
#         Of ocurse we're going to ignore that and find them all. That,
#         after all, is how we roll.
# 
#         Focusing on the numbers produced is daunting, as the values a
#         given digit may have changes drastically as it changes
#         positionally, so I think it best to not solve the problem
#         mathematically at all. We're looking at an ordered collection of
#         items and wish to divide it into groups, maintaining local
#         postional order. We can do that by focusing not on the items, but
#         rather on the division points.
# 
#         There are n-1 division points between items, in this case the
#         individual digits. Each point can either hold a division or not,
#         or occupy one of two states. Another way of saying this is we are
#         looking for a set of subsets of a set of n-1 elements, which has
#         2^n-1 elements. The states, whether we have a division between
#         two chaaracters or not, can be mapped to a bit in a binary number
#         matching that position: a three digit binary number can map to
#         the three divisions between four characters. If the bit is set,
#         we make a slice, or if it is not we leave the characters
#         connected. If we do this over the range from 0 to (2^n-1)-1 we
#         will create a template for every combination of splits and joins
#         possible between n characters, and hence every substring
#         combination.
# 
#         We are given a perfect square, so we know that the square root
#         will be an integer. Just to be sure we could validate our inpout
#         at this point to make sure we're all on the same page, so to
#         speak. 

        
        
        
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use List::Util qw( sum );

for my $num (1..100000) {
    
    $num *= $num;
    my @output = digipart( $num );
    next unless scalar @output;
    
    say "INPUT: ", $num;
    say "OUTPUT: found ", scalar @output, " solutions"; 

    for (1..scalar @output) {
        say join ' + ', (shift @output)->@*;
    }
    
    say '';

}

sub perfect_root ( $num ) {
## checks to see whether $num is a perfect square. If so, returns the
## square root, if not, returns 0
    my $root = int(sqrt $num);
    return $root**2 == $num
        ? $root
        : 0 ;
}

sub digipart ( $num ) {
    my $root = perfect_root( $num );
    my $div = length($num) - 1;
    my $bfmt = "%0${div}b";
    my @output;

    for (0..2**$div-1) {
        my $bin = sprintf $bfmt, $_;
        my @sliced = substr $num, 0, 1;
        for my $pos (0..$div-1) {
            substr ($bin, $pos, 1) == 1
                ? $sliced[-1] .= substr $num, $pos+1, 1
                : push @sliced,  substr $num, $pos+1, 1 ;
        }
        if ( sum(@sliced) == $root ) {
            push @output, \@sliced;
        }
    }
    return @output;
}

