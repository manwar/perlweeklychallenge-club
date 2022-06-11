#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

cmpthese( 500_000, {
  'grep' => sub { non_square(   100 ) },
  'for'  => sub { non_square_x( 100 ) },
});

cmpthese( 50_000, {
  'grep' => sub { non_square(   1000 ) },
  'for'  => sub { non_square_x( 1000 ) },
});

cmpthese( 5_000, {
  'grep' => sub { non_square(   10_000 ) },
  'for'  => sub { non_square_x( 10_000 ) },
});

cmpthese( 500, {
  'grep' => sub { non_square(   100_000 ) },
  'for'  => sub { non_square_x( 100_000 ) },
});

cmpthese( 100, {
  'grep' => sub { non_square(   1_000_000 ) },
  'for'  => sub { non_square_x( 1_000_000 ) },
});

sub non_square {
  my($N,@p2) = ($_[0],4);
  for(my$c=3;$c*$c<$N;$c+=2){
    ($_>$c)?((push@p2,$c*$c),last):$c*$c%$_||last for@p2;
  }
  return grep{my$t=$_;!grep{!($t%$_)}@p2}1..$N;
}

sub non_square_x {
  my ( $N, @p2, @r ) = ( @ARGV ? $ARGV[0] : 500 , 4 );

  P: for ( my $c = 3; $c*$c <= $N; $c += 2 ) {
    $_ > $c  ? last : $c*$c % $_ || next P for @p2;
    push @p2, $c*$c;
  }

  O: for my $t ( 1 .. $N ) {
    $_ > $t  ? last :    $t % $_ || next O for @p2;
    push @r, $t;
  }

  @r;
}
