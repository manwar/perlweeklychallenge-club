#!/usr/bin/perl
#https://theweeklychallenge.org/blog/perl-weekly-challenge-249/
use strict; use warnings; use v5.10;

if( @ARGV ) { say "@$_" for equal_pairs( @ARGV ) }
else        { run_tests() }

sub equal_pairs {
  my %ptr;                               #keeps track of where to add last elem of a pair
  my $all_is_pairs = 1;                  #true until otherwise proven
  grep $all_is_pairs,                    #return nothing unless all_is_pairs
  grep $all_is_pairs *= @$_ == 2,        #turned false for all if one array ref isn't a pair
  grep ref,                              #exclude array elements from push (push dont return ref's)
  map $ptr{$_}                           #if ptr for curr input value exists then
      ? push( @{ delete $ptr{$_} }, $_ ) #...pair up curr value with last equal value and forget/delete pointer, delete returns deleted value
      : ($ptr{$_} = [$_]),               #...else create a new pair where currently only one value exists
  @_;                                    #input array
}

sub run_tests {
  for(
      [  [3, 2, 3, 2, 2, 2]  => [ [3, 3], [2, 2], [2, 2] ]  ],
      [  [1, 2, 3, 4]        => []  ],
      [  [1, 2, 2, 4]        => []  ],
      [  [2, 2, 4, 4, 7]     => []  ],
      [  [7, 2, 2, 4, 4]     => []  ],
      [  [1..4,1..4]         => [ [1,1], [2,2], [3,3], [4,4] ]  ],
  ) {
    my( $input, $expected_pairs ) = @$_;
    my @got_pairs = equal_pairs( @$input );
    my($e, $g) = map "@{[map join('+',@$_), @$_]}", $expected_pairs, \@got_pairs;
    printf "%s   input: @$input   got: $g   expected_pairs: $e\n", $e eq $g ? 'ok' : '***NOT OK'
  }
}
