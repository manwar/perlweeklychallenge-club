#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my %H = map { $_=>1 } (
  1, 7, 10, 13, 19, 23, 28, 31, 32, 44, 49, 68, 70, 79, 82, 86, 91, 94, 97, 100,
  103, 109, 129, 130, 133, 139, 167, 176, 188, 190, 192, 193, 203, 208, 219, 226,
  230, 236, 239, 262, 263, 280, 291, 293, 301, 302, 310, 313, 319, 320, 326, 329,
  331, 338, 356, 362, 365, 367, 368, 376, 379, 383, 386, 391, 392, 397, 404, 409,
  440, 446, 464, 469, 478, 487, 490, 496, 536, 556, 563, 565, 566, 608, 617, 622,
  623, 632, 635, 637, 638, 644, 649, 653, 655, 656, 665, 671, 673, 680, 683, 694,
  700, 709, 716, 736, 739, 748, 761, 763, 784, 790, 793, 802, 806, 818, 820, 833,
  836, 847, 860, 863, 874, 881, 888, 899, 901, 904, 907, 910, 912, 913, 921, 923,
  931, 932, 937, 940, 946, 964, 970, 973, 989, 998, 1000
);

my @TESTS = map { [$_ => exists $H{$_} ? 1 : 0] } 1..1000;

my $I = 1e7;
cmpthese( 1, {
  'is_happy'         => sub { happy_list_is_happy(          $I ); },
  'is_precache'      => sub { happy_list_is_happy_precache( $I ); },
  'list_cache'       => sub { happy_list_cache(             $I ); },
  'list_cache_limit' => sub { happy_list_cache_limited(     $I ); },
  'list_precache'    => sub { happy_list_precache(          $I ); },
});

is( is_happy(          $_->[0] ), $_->[1] ) for @TESTS;
is( is_happy_precache( $_->[0] ), $_->[1] ) for @TESTS;
done_testing();

my $C = 300;
say join " - ", happy_list_is_happy(             $C );
say join " - ", happy_list_is_happy_precache(    $C );
say join " - ", happy_list_cache(                $C );
say join " - ", happy_list_precache(             $C );

sub happy_list_is_happy {
  my( $x, $count, @ret ) = (0, @_ ? $_[0] : 8 );
  $x++,is_happy($x) ? push @ret,$x : redo for 1..$count;
  @ret;
}

sub happy_list_is_happy_precache {
  my( $x, $count, @ret ) = (0, @_ ? $_[0] : 8 );
  $x++,is_happy_precache($x) ? push @ret,$x : redo for 1..$count;
  @ret;
}

## Simple subroutine to work out if a number is happy....
sub is_happy {
  my($n,$t,%seen) = shift;
  while($n>1) {
    return 0 if $seen{$n};
    $seen{$t=$n}=1,$n=0;
    do {$n+=($t%10)**2} while $t=int($t/10);
  }
  1;
}

## Now we compute all happy values - note we keep a record of happy
## values that we have seen to reduce the computational overhead
## at the expensive of memory used. Note we use an array for happy
## as it won't become sparse for large values of $count...

sub happy_list_cache {
  my $count= @_ ? $_[0] : 8, my %seen, my $t, state @happy = (0,my @ret = my $N = 1);
  OUT: for (2..$count) {
    %seen=();
    my $n = ++$N;
    while($n>1) {
      last if defined $happy[$n] && $happy[$n]==1;
      if(defined $happy[$n] || $seen{$n}) { ## Unhappy no...
        $happy[$_] = 0 foreach keys %seen;
        redo OUT;
      }
      $seen{$t=$n}=1,$n=0;
      do {$n+=($t%10)**2} while $t=int($t/10);
    }
    $happy[$_]=1 for keys %seen;
    $happy[$N]=1;
    push @ret,$N;
  }
  @ret;
}

## A memory saving version which only stores values for $n < 1540 (assumingn 64 bit
## signed integer perl)... Reduces the storage used - with little or no overhead
## This limit is decided because for any signed 64-bit integer the sum of squares of
## digits is bounded above by 19 * 9 * 9...

sub happy_list_cache_limited {
  my $count= @_ ? $_[0] : 8, my %seen, my $t, state @happy = (0,my @ret = my $N = 1);
  OUT: for (2..$count) {
    %seen=();
    my $n = ++$N;
    while($n>1) {
      last if defined $happy[$n] && $happy[$n]==1;
      if(defined $happy[$n] || $seen{$n}) { ## Unhappy no...
        ($_<1540) && ($happy[$_] = 0) for keys %seen;
        redo OUT;
      }
      $seen{$t=$n}=1,$n=0;
      do {$n+=($t%10)**2} while $t=int($t/10);
    }
    ($_<1540) && ($happy[$_]=1) for $N, keys %seen;
    push @ret,$N;
  }
  @ret;
}

## Take this a stage further in that we don't compute the cache on the fly but populate
## it when we first call the list function...

## Populate @happy for 19*9*9 entries.... (19 digit numbers)
## $happy[$n] = 1 if happy of 0 if unhappy...

## Then if $N <= 1540 we can just use the value from @happy..
## If $N > 1540 we can just compute the sum of digits - which we
## know is less than 1540 - and look it up in @happy
## This is assuming that $N is a 64-bit signed integer which is the
## perl limit. If you were working with 128-bit signed ints then you
## would raise the size of @happy to 3160 (39 digit numbers)

## This pre-population of the happy array means that the execution
## of the rest of the code is clean and simple - and we don't need
## the the loop - so very fast!

sub happy_list_precache {
  state @happy;
  my( $L, $count, $t, @ret, %seen ) = ( 1_640, @_ ? $_[0] : 8 );

  unless( @happy ) {
    @happy=(0,1);
    O: for my $N ( 2..$L ) {
      my $n = $N;%seen=();
      while($n>1){
        last if defined $happy[$n] && $happy[$n]==1;
        if( defined $happy[$n] || $seen{$n} ) {
          $happy[$_]=0 for keys %seen;
          next O;
        }
        $seen{$t=$n}=1,$n=0;
        do {$n+=($t%10)**2} while $t=int($t/10);
      }
      $happy[$_]=1 for $N, keys %seen;
    }
  }

  ## Now loop through until we have a list of first $count happy
  ## numbers.
  ## If we wanted to use this method in an if_happy function - could
  ## equally replace this with
  ## return $happy[$N] if $N <= $L;
  ## my $n=0;
  ## do {$n+=($N%10)**2} while $N=int($N/10);
  ## return $happy[$n];
  my $N=0;
  for (1..$count) {
    $N++;
    if( $N <= $L ) {
      $happy[$N] || redo;
    } else {
      my $n=0,$t=$N;
      do {$n+=($t%10)**2} while $t=int($t/10);
      $happy[$n] || redo;
    }
    push @ret,$N;
  }
  @ret;
}

## We can use the same principal to make a version of is_happy
## which uses the cache - which reduces to:

sub is_happy_precache {
  state @happy;
  my( $L, $N, $t, @ret, %seen ) = ( 1_640, $_[0] );

  unless( @happy ) {
    @happy=(0,1);
    O: for my $N ( 2..$L ) {
      my $n = $N;%seen=();
      while($n>1){
        last if defined $happy[$n] && $happy[$n]==1;
        if( defined $happy[$n] || $seen{$n} ) {
          $happy[$_]=0 for keys %seen;
          next O;
        }
        $seen{$t=$n}=1,$n=0;
        do {$n+=($t%10)**2} while $t=int($t/10);
      }
      $happy[$_]=1 for $N, keys %seen;
    }
  }

  if( $N > $L ) {    ## If not in cached array we compute
    my $n=$N,$N=0;   ## the sum of digits squared....
    do {$N+=($n%10)**2} while $n = int($n/10);
  }
  $happy[$N];        ## And look up value in the cache..
}

