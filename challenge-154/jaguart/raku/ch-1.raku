#!/usr/bin/env raku
use v6;
=begin pod

=begin CHALLENGE

TASK #1: Missing Permutation

You are given possible permutations of the string 'PERL'.
Write a script to find any permutations missing from the list.

=end CHALLENGE

=end pod

# V2 - mark-anderson++ - no need to write permutations, use Raku's

#| Generate permutations from $str and list those NOT on the remainder of the command-line.
sub MAIN ( Str:D $str, +@not ) {

  # Notes:
  #   Str.comb          -> List of chars
  #   List.permutations -> all possible combinations as Lists
  #   >>.join           -> reassemble permutation Lists into strings using hyper
  #   (-)               -> Set substraction, returns Set
  #   Set.keys          -> we want the elements as a List

  say 'Permutations:  ', $str.comb.permutations>>.join;
  say 'Exclude:       ', ( |@not );
  say 'Leaving:       ', ( $str.comb.permutations>>.join (-) |@not ).keys;

}

#| UNUSED - Long-form algorithm to generate permutations.
#| Returns an Array, retained for hysterical raisens.
sub permutate( Str:D $str, Int $at = 0 ) returns Array of Str {
  my @result;
  if $at == $str.chars-1 {
    @result.push($str);
  }
  else {
    my $a = [ $str.comb ];
    for $at .. $a.elems-1 -> $i {
      $a[$at,$i] = $a[$i,$at];  # swap and generate
      @result.push( |permutate( $a.join, $at+1 ) );
      $a[$at,$i] = $a[$i,$at];  # swap back for next iteration
    }
  }
  return @result;
}

