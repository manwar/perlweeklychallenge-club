#!raku

#
# Perl Weekly Challenge 239
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-239/>
#

# $ raku raku/ch-1.p6 --words1='a''bc' --words2='ab''c'
# true
sub MAIN( :@words1, :@words2 ) {
    'true'.say and exit if ( @words1.join ~~ @words2.join );
    'false'.say;
}
