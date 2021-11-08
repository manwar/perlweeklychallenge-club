#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       pairing-up-paring-down.pl
#
#       Find Pairs
#         Submitted by: Yary
#         You are given a string of delimiter pairs and a string to search.
# 
#         Write a script to return two strings, the first with any
#         characters matching the “opening character” set, the second with
#         any matching the “closing character” set.
# 
#         Example 1:
#             Input:
#                 Delimiter pairs: ""[]()
#                 Search String: 
#                     "I like (parens) and the Apple ][+" they said.
#     
#             Output:
#                 "(["
#                 ")]"
#         Example 2:
#             Input:
#                 Delimiter pairs: **//<>
#                 Search String: 
#                     /* This is a comment (in some languages) */ <could be a tag>
#     
#             Output:
#                 /**/<
#                 /**/>

#             method:
#                 the harder you look the messier this problem gets. Nested delimiters get 
#                 particularly so. Some assumptions:
#                     1. with matching delimiters, the second occurance should 
#                         close the first.
#                     2. a closing delimiter cannot be the opener for a different pair.
#                     3. a delimiter is only one character. Example 2 breaks the common 
#                         comment pair /* into two individual delimiters. 
#                     4. should we acknowledge a close without an open before it? Hmmm...
#                     
#                 Oh but wait, that's not the problem. The problem wants a filtered 
#                 list of characters from the open set and the same from the closed. That's 
#                 it. No counting openings and closings — none of that. We'll break it into 
#                 an array of chars and use grep, then rejoin. Easy-peasy. 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


# my $delims = q|""[]()|;
# my $input  = q|"I like (parens) and the Apple ][+" they said.|;

my $delims = q|**//<>|;
my $input  = q|/* This is a comment (in some languages) */ <could be a tag>|;




my ($open, $close) = parse_delimiters( $delims );

my @input = split //, $input;
my $o_chars = join '', grep { exists $open->{$_}  } @input;
my $c_chars = join '', grep { exists $close->{$_} } @input;

say <<~"END";
    input   $input
    delims  $delims
    
    opens   $o_chars
    closes  $c_chars
    END
    
sub parse_delimiters ( $pair_str ) {
    my ( %open, %close );
    while (length $pair_str > 0) {
        $open{  substr $pair_str, 0, 1, '' } = undef;
        $close{ substr $pair_str, 0, 1, '' } = undef;
    }
    return \%open, \%close;
}














# use Test::More;
# 
# is 
# 
# done_testing();
