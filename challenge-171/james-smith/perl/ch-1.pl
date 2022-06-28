#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

my $N = $ARGV[0]//20;
##
## Fron task 1 we steal our "recursive" compose function
## so we can stitch methods together.
##

sub compose {
  my($g,$f) = pop;
  @_ && ($f = pop) ? compose( @_, sub { $f->($g->(@_)) } ) : $g
}

sub is_abundant {
  my $s = 1 - (my $t = pop);
  $s += $t%$_ ? 0 : $t-$_*$_ ? $_+$t/$_ : $_ for 2..sqrt $t;
  $s>0;
}


my $is_abundant = compose
  ## Check value is greater than 0.
  sub { pop > 0 },
  ## Simple sum...
  sub { my $s = 0;
        $s+=$_ for @_;
        $s
      },
  ## Find factors... We add -$t to the list
  ## As we want to add up sum of factors > $t...
  sub { my $t = pop;
        -$t, 1, map { $t%$_ ? () : $t-$_*$_ ? ($_,$t/$_) : $_ } 2..sqrt $t
      };

## Loop one - using the simple function...
say '';
my $k = 1;    is_abundant($k+=2) ? say $k : redo for 1..$N;
say '';

## Loop two - using the chained methods using compose...
my $t = 1; $is_abundant->($t+=2) ? say $t : redo for 1..$N;
say '';

