#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Test::More;
use Const::Fast qw(const);
use Time::HiRes qw(time);

const my @RARE_ENDS => ( [2,[2]], [4,[0]], [6,[0,5]], [8,[2,3,7,8]] );
const my @F=>(0,1,0,1,1,0,1,1,0); ## rare_numbers have a digit sum
                                  ## (value mod 9) of either 9/0,2,5 or 8

is( "@{[ rare_numbers( 2  ) ]}", '65' );
is( "@{[ rare_numbers( 6  ) ]}", '621770' );
is( "@{[ rare_numbers( 9  ) ]}", '281089082' );
is( "@{[ rare_numbers( 10 ) ]}", "2022652202 2042832002" );
is( "@{[ rare_numbers( 12 ) ]}", "868591084757 872546974178	872568754178" );

done_testing();

## Values of the first digit/last digit - there are only 8 of these
## which immediately reduces the search space by 12.5 times...

sub rare_numbers {
  my $size = shift;
  my $time = time;
  return () if $size < 2; ## No solutions for size <2 as the as the
                          ## number is the reverse of itself so will
                          ## fail the $x!=$y constraint
  ## List of start/end values
  sub is_rare {
    sub is_sq {
      state %cache;
      return $cache{$_[0]} if exists $cache{$_[0]};
      return $cache{$_[0]} = $_[0] =~ m{[014569]$} &&
                             $_[0] == (int sqrt $_[0])**2;
    }

    my $x = shift;
    return () if $F[$x%9]; ## Digit sum is wrong...
    my $y = reverse $x;
    return () if $x == $y; ## Musn't be the same back and forth
    return $y if $x<$y && is_sq($x+$y) && is_sq($y-$x);
    ## Check both ways round!
    return $x if $y<$x && is_sq($x+$y) && is_sq($x-$y);
    return ();
  }

  my %res;
  my $low  = $size <= 4 ? '' : '0' x ($size-4);
  my $high = $size <= 4 ? '' : '9' x ($size-4);
  foreach my $tup ( @RARE_ENDS ) {
    my $s = $tup->[0];             ## first digit has to be even 2,4,6,8
    foreach my $e (@{$tup->[1]}) { ## second digit has to be in list
                                   ## defined above
      if( $size == 2 ) {           ## As our method really starts at 4
                                   ## let us deal with 2 & 3 cases first
                                   ## as the optimized code is for
                                   ## numbers of length 4 or more
        $res{$_}=1 foreach is_rare("$s$e");
        next;
      }
      if( $size == 3 ) {
        $res{$_}=1 foreach map { is_rare("$s$_$e") } 0..9;
        next;
      }

      ## Now we need to do the next group....
      foreach my $b (0..9) {    ## These are filters to apply
        foreach my $f (0..9) {  ## for each group of numbers....
          next if $s==2 && $b!=$f
            || $s==4 && ($b-$f)%2
            || $s==6 && ! ($b-$f)%2
            || $s==8 && (
                  $e==2 && $b+$f!=9
               || $e==3 && $b-$f!=7 && $f-$b !=3
               || $e==7 && $b+$f!=1 && $b+$f !=11
               || $e==8 && $b!=$f
            );
          ## Now we try all additional numbers....
          ## The sequence '000' .. '999' gives all 3 digit numbers.... !
          $res{$_}=1 foreach map { is_rare("$s$b$_$f$e") } $low..$high;
        }
      }
    }
  }
  my $dur = time-$time;
  my $hrs = int ($dur/3600);
  my $dur2 = $dur-$hrs*3600;
  my $min = int ($dur2/60);
  my $sec = $dur2-$min*60;
  warn sprintf "Time taken (for %d): %10d %2d %6.3f (%12.3f)\n",
    $size, $hrs, $min, $sec, $dur;
  return sort keys %res;
}

