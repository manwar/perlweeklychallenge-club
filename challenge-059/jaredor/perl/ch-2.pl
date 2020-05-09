#!/usr/bin/env perl

use v5.012;
use warnings;
use bigint;
use Config;
use List::Util qw(all sum max);

# PWC 059, TASK #2 : Bit Sum

# Answer based on perl doc for unpack and www.perlmonks.org/?node_id=407933

my ( $LL, $NN ) =
  defined $Config{longlongsize}
  ? ( 8 * $Config{longlongsize}, 'Q' )
  : ( 8 * $Config{longsize}, 'L' );

my $CHOP_SIZE = 2**${LL};
my $CHOP_ZERO = pack "${NN}", 0;

die "This script requires one or more positive integer arguments."
  unless @ARGV;

die "Not all arguments to the script are positive integers."
  unless all { /\A [1-9] \d* \Z/xms } @ARGV;

#my @nums = map { pack "${NN}*", $_ } @ARGV;

sub chop_up {
    my ( $num, @chopped ) = ( 0 + $_[0], );
    while ($num) {
        push @chopped, $num % $CHOP_SIZE;
        $num = int( $num / $CHOP_SIZE );
    }
    return [ map { pack "${NN}", $_ } @chopped ];
}

my @nums  = map     { chop_up $_ } @ARGV;
my $chops = max map { $#$_ } @nums;
( $chops - $#$_ ) and push @$_, ($CHOP_ZERO) x ( $chops - $#$_ ) for @nums;

my ( @diffbits, $numa );
while ( $numa = shift @nums ) {
    for my $numb (@nums) {
        push @diffbits, unpack( "%${LL}b*", $numa->[$_] ^ $numb->[$_] )
          for 0 .. $chops;
    }
}
say @diffbits ? sum @diffbits : 0;
