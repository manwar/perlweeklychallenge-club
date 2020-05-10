#!/usr/bin/env perl

use v5.012;
use warnings;
use bigint;
use Config;
use List::Util qw(all sum);

# PWC 059, TASK #2 : Bit Sum

# Answer based on perl doc for unpack and www.perlmonks.org/?node_id=407933

die "This script requires one or more positive integer arguments."
  unless @ARGV;

die "Not all arguments to the script are positive integers."
  unless all { /\A [1-9] \d* \Z/xms } @ARGV;

my ( $LL, $NN ) =
  defined $Config{longlongsize}
  ? ( 8 * $Config{longlongsize}, 'Q' )
  : ( 8 * $Config{longsize}, 'L' );

my $WORD = 2**$LL;

sub num2bitstr {
    my ( $numstr, $bitstr ) = ( $_[0], );
    $bitstr .= pack "${NN}", $numstr % $WORD and $numstr /= $WORD while $numstr;
    return $bitstr;
}

my @nums = map { num2bitstr $_ } @ARGV;

my ( @diffbits, $num );
while ( $num = pop @nums ) {
    push @diffbits, unpack( "%${LL}b*", $num ^ $_ ) for @nums;
}
say @diffbits ? sum @diffbits : 0;
