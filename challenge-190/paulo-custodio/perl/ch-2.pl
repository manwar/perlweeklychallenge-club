#!/usr/bin/perl

# Challenge 190
#
# Task 2: Decoded List
# Submitted by: Mohammad S Anwar
#
# You are given an encoded string consisting of a sequence of numeric
# characters: 0..9, $s.
#
# Write a script to find the all valid different decodings in sorted order.
#
#     Encoding is simply done by mapping A,B,C,D,… to 1,2,3,4,… etc.
#
# Example 1
#
# Input: $s = 11
# Output: AA, K
#
# 11 can be decoded as (1 1) or (11) i.e. AA or K
#
# Example 2
#
# Input: $s = 1115
# Output: AAAE, AAO, AKE, KAE, KO
#
# Possible decoded data are:
# (1 1 1 5) => (AAAE)
# (1 1 15)  => (AAO)
# (1 11 5)  => (AKE)
# (11 1 5)  => (KAE)
# (11 15)   => (KO)
#
# Example 3
#
# Input: $s = 127
# Output: ABG, LG
#
# Possible decoded data are:
# (1 2 7) => (ABG)
# (12 7)  => (LG)

use Modern::Perl;

sub decodings_ {
    my($result, $prefix, $suffix)=@_;
    if ($suffix eq "") {
        push @$result, $prefix;
    }
    else {
        if ($suffix =~ /^(\d\d)/ && $1>=1 && $1<=26) {
            my $char=chr($1+ord('A')-1);
            my $rest=$';
            decodings_($result, $prefix.$char, $rest);
        }
        if ($suffix =~ /^(\d)/ && $1>=1 && $1<=26) {
            my $char=chr($1+ord('A')-1);
            my $rest=$';
            decodings_($result, $prefix.$char, $rest);
        }
    }
}

sub decodings {
    my($in)=@_;
    my @result;
    decodings_(\@result, "", $in);
    return sort @result;
}

say join ", ", decodings(shift);
