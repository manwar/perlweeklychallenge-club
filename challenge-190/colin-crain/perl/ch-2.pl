#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       partition-code.pl
#
#         Decoded List
#         Submitted by: Mohammad S Anwar
#         
#         You are given an encoded string consisting of a sequence of
#         numeric characters: 0..9, $s.
# 
#         Write a script to find the all valid different decodings in
#         sorted order.
# 
#         Encoding is simply done by mapping A,B,C,D,… to 1,2,3,4,… etc.
# 
#         Example 1
# 
#             Input: $s = 11
#             Output: AA, K
# 
#                 11 can be decoded as (1 1) or (11) i.e. AA or K
# 
#         Example 2
# 
#             Input: $s = 1115
#             Output: AAAE, AAO, AKE, KAE, KO
# 
#                 Possible decoded data are:
#                 (1 1 1 5) => (AAAE)
#                 (1 1 15)  => (AAO)
#                 (1 11 5)  => (AKE)
#                 (11 1 5)  => (KAE)
#                 (11 15)   => (KO)
# 
#         Example 3
# 
#             Input: $s = 127
#             Output: ABG, LG
# 
#                 Possible decoded data are:
#                 (1 2 7) => (ABG)
#                 (12 7)  => (LG)

#         method:
# 
#             Combinatorically speaking, I'm not sure what the correct term
#             is for the ordered partioning a string like this, but the
#             mathematics behind it are actually pretty simple. Each new
#             character considered has only two choices available to it:
#             either to be included in the previous partition, if any, or
#             become the start of a new partition. Both outcomes, resulting
#             in two differing partition patterns, is also an option. This
#             constant bifurcation produces n^2 possibilities. The first
#             character, though, only has one option, an must initiate a
#             new partition. Thus the final count of all possible
#             partitionings is
# 
#                 (n-1)^2
# 
#             However we will not need ot consider all of these, as we are
#             restrained by the fact that valid patitions can only produce
#             the integer values in the range 1 to 26, mapping the complete
#             alphabet.
# 
#             Thus each partition can only be of length 1 or 2 digits,  and
#             should it have two, the first digit can only be 1 or 2. If we
#             put in a condition to check this before constructing these
#             options we can dramatically reduce the number of partition
#             patterns, making even very large code blocks to be sorted.

#             A special case must be made for 0, as no letter will map to
#             it in itself but it will required to compose the code numbers
#             10 and 20. This number can only be concatenated on recursion,
#             resulting in a single case. If it can only form numbers
#             greater than 20 it will neither trigger a new decoded letter
#             as itself or as a compound and will ultimately be ignored. 

#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

## example: 24,000 partitionings possible
my $out = decode_partitions( "1563152118195912152252515211923552095");



sub decode_partitions ( $num ) {
    ## 1 => A, 2 => b, 3 => C, ...  
    my %decode;
    @decode{ 1..26 } = ("A".."Z");
        
    for my $part ( extract_partitions( $num )->@* ) {
        say map {$decode{$_}} $part->@*;
    }
}

sub extract_partitions ( $num ) {
    my $groupings = [];
    
    ## the first partition is always the first character. It may grow later. 
    my @parts = substr $num, 0, 1, '';
    _recurse( $num, $groupings, @parts );

    sub _recurse ( $digits, $groupings, @parts ) {
        if ( length $digits == 0 ) {
            push $groupings->@*, \@parts;
            return;
        }

        my $prev = $parts[-1];
        my $new  = substr($digits, 0, 1);

        ## case make new partition
        if ( $new != 0 ) {
            _recurse( substr($digits, 1), 
                      $groupings, 
                      (@parts, $new) );  
        }
        
        ## case character added to previous partition
        if ( $prev . $new <= 26 ) {
             $parts[-1] .= $new;
             _recurse( substr($digits, 1), 
                       $groupings, 
                       @parts  )
        }
    }

    return $groupings;
}

