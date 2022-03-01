#!/usr/bin/env raku
use v6;

=begin pod

=head1 Challenge-154 Missing Permutation

TASK #1: Missing Permutation

You are given possible permutations of the string 'PERL'. Write a script to find any permutations missing from the list.

=begin SYNOPSIS
=begin code

  ./ch-1.raku PERL | wc -l # 24 permutations
  ./ch-1.raku PERL LERP ERPL | wc -l # 22 permutations

=end code
=end SYNOPSIS

=begin CAVEATS
Does NOT filter out duplicates when the same character occurs multiple times.

=begin code
  ./ch-1.raku aab
  aab
  aba
  aab
  aba
  baa
  baa
=end code

=end CAVEATS

=AUTHOR
Solutions by git:jaguart Jeff Armstrong.

=begin NOTE

=item1 First contribution to https://theweeklychallenge.org/
=item1 Raku newbie, ex Perl

=end NOTE

=end pod


sub MAIN ( Str:D $str, +@not ) {
  my %not = @not.map({$_ => True});
  permutate( $str )
    .grep({ !%not{$_} })
    .map({ say $_});

}

sub permutate( Str:D $str, Int $at = 0 ) returns List {
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

