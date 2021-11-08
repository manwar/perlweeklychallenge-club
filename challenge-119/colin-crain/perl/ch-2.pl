#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       chaperone-required.pl
# 
#       Sequence without 1-on-1
#         Submitted by: Cheok-Yin Fung
#         Write a script to generate sequence starting at 1. Consider the
#         increasing sequence of integers which contain only 1’s, 2’s and 3’s,
#         and do not have any doublets of 1’s like below. Please accept a
#         positive integer $N and print the $Nth term in the generated sequence.
# 
#         1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, …
# 
#         Example
#         Input: $N = 5
#         Output: 13
# 
#         Input: $N = 10
#         Output: 32
# 
#         Input: $N = 60
#         Output: 2223
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use 5.32.0;

use warnings;
use strict;
use utf8;
use feature qw(signatures);
no warnings 'experimental::signatures';


my $ele = shift // 60;

say make_sequence( $ele )->[$ele-1];


## faster, base-4
sub make_sequence ($quan, $i = 0) {   
    my @seq;
    while (@seq < $quan) {
        my ($num, $rem) = (++$i, '');
        my $val = '';
        while ( $num > 0  ) {
            ($num, $rem) = (int( $num/4 ), $num % 4);   
            $val = $rem . $val;
        }
        next if $val =~ /0|11/;
        push @seq, $val;
    }
    return \@seq;
}

## simpler, but more chaff, less wheat
sub make_sequence10 ( $quan, $i = 0 ) {
    my @seq;
    while ( ++$i ) {
        next if $i =~ /[^123]|11/;
        push @seq, $i;
        last if @seq == $quan;
    }
    return \@seq;
}

# use Benchmark qw( cmpthese );
# 
# cmpthese(0, {
#     'four'     => sub {  make_sequence(50) },
#     'ten'      => sub {  make_sequence10(50) }  } );

oct
