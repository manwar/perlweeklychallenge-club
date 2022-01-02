#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 'redivider', 'r redivider e edivide d divid i ivi v'],
  [ 'deific',    'd e i ifi f c'],
  [ 'llama',     'l ll a ama m' ],
  [ 'rotors',    'r rotor o oto t s'],
  [ 'challenge', 'c h a l ll e n g'],
  [ 'champion',  'c h a m p i o n'],
  [ 'christmas', 'c h r i s t m a'],
  [ 'tattarrattat', 't tat tattarrattat a atta attarratta tt ttarratt tarrat arra r rr'],
  [ 'bobaboba',  'b bob bobabob o obabo bab a aboba'],
  [ 'llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch', 'l ll a n f i r p w g y gog o e c h d b lll llll t s ili ogo ogogo ogogogo gogog' ],
);

is( stringify( eertree($_->[0]) ), $_->[1] ) for @TESTS;
done_testing();

sub eertree {
  my $str = [split //, $_[0]];
  ## Create the null tree..., two nodes...
  my $tree = {
    -1  => { 'start' => undef, 'edges' => {}, 'suff' => -1 },
    q() => { 'start' => undef, 'edges' => {}, 'suff' => -1 },
  };
  ## add nodes (single letter nodes to the "-1" part of the tree )
  ##           (double letter nodes to the "" part of the tree   )

  add_str( $tree, $str, -1, $_, $_   ),
  add_str( $tree, $str, q(), $_, $_+1 ) for 0.. @{$str}-1;

  $tree;
}

sub add_str {
  my( $tr, $c, $node, $st, $en ) = @_;

  ## exit loop if the start or end values are outside the string
  ## OR the start and end characters are different.

  while( $st >=0 && $en < @{$c} && $c->[$st] eq $c->[$en] ) {

    ## Add new palindrome as an "edge" of the current node - if
    ## no already added {use an index value!)
    ##
    ## Then create the new node - with a link back to the suffix
    ## node...
    ##
    ## Finally expand the palindrome by 1 character either way...

    $tr->{$node}{'edges'}{my $s = join q(), @{$c}[$st..$en] } ||= keys %{$tr->{$node}{'edges'}};
    $tr->{$node=$s} ||= { 'start' => $st, 'edges' => {}, 'suff' => $st==$en ? -1 : $en==$st+1 ? q() : $c->[$st] };
    $st--;
    $en++;
  }
}

sub stringify {
  my $tr = shift;
  join q( ),
  sort { $tr->{$a}{'start'} <=> $tr->{$b}{'start'} ||
         length $a <=> length $b
       }
  grep { defined $tr->{$_}{'start'} }
  keys %{$tr};
}
