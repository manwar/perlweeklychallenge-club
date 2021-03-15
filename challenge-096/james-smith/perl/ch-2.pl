#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my ($calls,$misses,%cache,%cache_x) = (0,0);

my %examples = (
 'fred,bob' => 4,
 'fred,' => 4,
 ',fred' => 4,
 ',' => 0,
 'rating,ratting' => 1,
 'kitten,sitting' => 3,
 'sunday,monday' => 2,
 'boat riding,bat ridding' => 2,
);

foreach my $words (sort keys %examples ) {
  my($s1,$s2) = split m{,}, $words;
  $s1||='';
  $s2||='';
  print "\n";
  print render_alignment($s1,$s2);
  is( edit_distance($s1,$s2), $examples{$words} );
  is( edit_distance_simple($s1,$s2), $examples{$words} );
}

done_testing();

printf "Calls: %d, hits: %d (%0.2f%%), misses: %d (%0.2f%%)\n",
  $calls,
  $calls-$misses, ($calls-$misses)/$calls*100,
  $misses,        $misses/$calls*100;

## Notes:
## --------------------------------------------------------------------
##
## I'm just going to add "Another day job challenge!"
##
## To be able to make "nicer" output - rather than just keeping track
## of the edit distance of substrings - we will actually keep the
## alignment of the two words as a string of "operations" whether they
## be Indels or SNPs.
##
## {One of my background is working with genomic data and this can be
## thought of as a simple alignment algorithm - and so I think of the
## three operations as Indels {inserts/deletes - remembering an insert
## into one sequence is just the same as a delete from the other} and
## SNPs - or single nucleotide polymorphisms.
##
## The simple alignment string representation we will use consists of:
##   '|' - the letters are the same;
##   'v' - insert
##   '^' - delete
##   ' ' - SNP/modify
##
## We can convert this to an edit distance by counting all the non-"|"s
## In perl we do this with tr/^v /^v / which returns the number of
## matches in scalar form. See {_edit_dist - function}
##
## Finally we include a nice way to render the alignment {edits}
## By showing the two words with appropriate inserts in each word
## and indicate where the letters match in each word via a the
## alignment string in the middle
##
## Additional note - we "memoise" the alignment function - as it will
## be called with the same subseq of letters following different paths
## through the two sequences. This increases performance...
##
## From a "genomic" point of view this is known as the basis of the
## Smith-Waterman local alignment algorithm. Although Smith-Waterman
## has other features - including variable "penalties" for each type
## of edit {inserts, deletes, modifications}. Even having different
## penalties for certain changes {this is also similar to how typing
## correction software works - with assuming adjacent key typos are
## more likely.
##
## See:
##  * https://en.wikipedia.org/wiki/Smith%E2%80%93Waterman_algorithm

sub edit_distance {
  return _edit_dist( alignment_string( @_ ) );
}

sub alignment_string {
  my( $s, $t ) = @_;
  $calls++;
  my $key = "$s\t$t";
  return $cache{$key} if exists $cache{$key};
  $misses++;
  ## Both strings are empty so reached end!
  return $cache{$key}||=''              if $t eq q() && $s eq q();
  ## Exhausted t so all edits are now deletes...
  return $cache{$key}||='^' x length $s if $t eq q();
  ## Exhausted s so all edits are now inserts...
  return $cache{$key}||='v' x length $t if $s eq q();
  ## First letters are the same so we just prepend the
  ## match symbol (|) and continue...
  return $cache{$key}||='|'.alignment_string(substr($s,1),substr($t,1))
                                        if ord $s == ord $t;

  ## We now have three choices - "insert", "delete" or "SNP"
  my($d,$i,$m) = (
    '^'.alignment_string( substr($s,1), $t           ),
    'v'.alignment_string( $s,           substr($t,1) ),
    ' '.alignment_string( substr($s,1), substr($t,1) ),
  );
  return  $cache{$key}||=
        _edit_dist( $d ) < _edit_dist( $i )
    ? ( _edit_dist( $d ) < _edit_dist( $m ) ? $d : $m )
    : ( _edit_dist( $i ) < _edit_dist( $m ) ? $i : $m );
}

sub _edit_dist { ## Count inserts(v), deletes(^) & mis-matches( )
  return $_[0] =~ tr/^v /^v /;
}

sub render_alignment {
  my( $s, $t ) = @_;
  my $a = alignment_string( $s, $t );
  my( $top, $bot ) = ( '','' );
  foreach ( split m{}, $a ) {
    $top .= $_ eq 'v' ? '-' : substr $s, 0, 1, '';
    $bot .= $_ eq '^' ? '-' : substr $t, 0, 1, '';
  }
  return sprintf "%s\n%s (%d)\n%s\n",
    $top, $a, _edit_dist($a), $bot;
}

#### Optimal code - without the alignment string....
# Reduction to a single line
# We can use sort here as it is relatively fast anyay
# o/w could load in List::Util - but I think overall this will
# be quicker!

sub edit_distance_simple {
  my( $s, $t ) = @_;
  return $cache_x{"$s\t$t"}||=
     $t eq q()          ? length $s
   : $s eq q()          ? length $t
   : (ord $s == ord $t) ? edit_distance(substr($s,1),substr($t,1))
   :                      1+(sort { $a <=> $b }
                            edit_distance(substr($s,1),$t),
                            edit_distance($s,substr$t,1),
                            edit_distance(substr($s,1),substr $t,1)
                          )[0]
   ;
}

