#!/usr/bin/env perl

use v5.012;
use warnings;
use Config;
use List::Util qw(all sum);

# PWC 059, TASK #2 : Bit Sum

# Answer based on perl doc for unpack and www.perlmonks.org/?node_id=407933

my ( $LL, $NN ) =
  defined $Config{longlongsize}
  ? ( 8 * $Config{longlongsize}, 'Q' )
  : ( 8 * $Config{longsize}, 'N' );

die "This script requires one or more positive integer arguments."
  unless @ARGV;

die "Not all arguments to the script are positive integers."
  unless all { /\A [1-9] \d* \Z/xms } @ARGV;

my @nums = map { pack "${NN}*", $_ } @ARGV;

my (@diffbits, $num);
while ($num = shift @nums) {
    push @diffbits, unpack( "%${LL}b*", $num ^ $_ ) for @nums;
}
say @diffbits ? sum @diffbits : 0;
