#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my @examples = (
  [ [qw(abc dea cd)], 1, 1 ],
  [ [qw(ade cbd fgh)], 0, 0 ],
  [ [qw(ab bc ca de ef fd)], 0, 1 ],
  [ [qw(ab bc ca ae)], 0, 1 ],
  [ [qw(bad bed bid bod bud dub dob dib deb dab)], 1, 1 ],
  [ [qw(abc def fed)], 0, 1 ],
);

foreach (@examples) {
  is(circ_single(@{$_->[0]}),$_->[1]);
  is(circ_any(   @{$_->[0]}),$_->[2]);
}
done_testing();

sub circ_single {
  my @words = @_;
  my %F;
  ($F{substr$_,0,1}++,$F{substr$_,-1}--) foreach @words;
  return 0 if grep {$_} values %F; ## This quickly filters out those cases in which we
                                   ## can't join end on end... now there is a harder
                                   ## problem coming up which is to work out if there
                                   ## is a multi-loop option
                                   ## e.g. "ab","bc","ca","de","ef","fd" - which
                                   ## can't make a single loop...
  ## nested sub-function which does the exhaustive/recurisve search for a single
  ## "circle"...
  sub exhaust {
    my ($init,@words) = @_;
    my $n = @words;
    ## If we have just two "words" then check that they form a loop.
    if( $n==1) {
      return substr($init,-1)  eq substr($words[0],0,1)
          && substr($init,0,1) eq substr($words[0],-1)  ? 1 : 0;
    }
    ## o/w we loop through the list of words...
    ## if the start of one word matches the end of the "first word"
    ## then we "extend" the first word, and repeat recursively,
    ## returning 1 if we eventually reach the criteria above...
    foreach(1..$n) {
      push @words,shift @words;
      next unless (substr $init,-1) eq substr $words[0],0,1;
      return 1 if exhaust( $init.$words[0], @words[1..($n-1)] );
    }
    ## In none match criteria we return 0...
    return 0;
  }

  return exhaust( @words );
}

sub circ_any {
  my (@words) = @_;
  my $n = @words;
  ## If we have just two "words" then check that they form a loop.
  ## o/w we loop through the list of words...
  ## if the start of one word matches the end of the "first word"
  ## then we "extend" the first word, and repeat recursively,
  ## returning 1 if we eventually reach the criteria above...
  foreach(1..$n) {
    my $init = shift @words;
    foreach(2..$n) {
      push @words,shift@words;
      next unless (substr $init,-1) eq substr $words[0],0,1;
      return 1 if substr($init,0,1) eq substr($words[0],-1);
      return 1 if circ_any( $init.$words[0], @words[1..($n-2)] );
    }
    push @words,$init;
  }
  ## In none match criteria we return 0...
  return 0;
}
