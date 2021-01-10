=begin comment
Perl Weekly Challenge-094-1 
https://perlweeklychallenge.org/blog/perl-weekly-challenge-094/

You are given an array of strings @S.

Write a script to group Anagrams together in any random order.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

    Input:  ("opt", "bat", "saw", "tab", "pot", "top", "was")
    Output: [ ("bat", "tab"),
              ("saw", "was"),
              ("top", "pot", "opt") ]

    Input:  ("x")
    Output: [ ("x" ]


Write a script to count maximum points on a straight line when given co-ordinates plotted on 2-d plane.

=end comment

#| Class to store groups of anagrams
class Group {
  has SetHash $.anagram = ().SetHash;

  method equal( $new_anagram ) {
    return True if $.anagram.pick.split('').sort ~~ $new_anagram.split('').sort;
  }

  method add( $new_anagram ) {
    $.anagram.set($new_anagram);
  }

}

sub challenge( @anagrams ) {

  my @result;

  # Recursive function thtat finds similar anagrams
  sub anagram( @anagrams ) {
    return @anagrams if @anagrams.elems lt 1;
    my $group = Group.new;
    $group.add( @anagrams.shift );
    my @index;
    for @anagrams -> $anagram {
      # Identify anagrams that are in $group
      @index.push: @anagrams.first($anagram, :k) if $group.equal($anagram);
      # add anagram to $group and remove it from @anagrams
      @index.map: { $group.add: @anagrams.splice($_,1) };
    }
    # add group of anagrams to @result
    @result.push: $group.anagram.keys.Set; 
    anagram( @anagrams );
  }
  anagram( @anagrams ); 
  return @result;
}

multi sub MAIN( @example ) {
  say "Input:  " ~ @example.raku;
  say 'Output: ' ~ challenge(@example).raku;
}

multi sub MAIN( 'challenge' ) {
  my @examples = ("opt", "bat", "saw", "tab", "pot", "top", "was").Array, ("x").Array;
  @examples.map: { MAIN($_) };
}

multi sub MAIN( 'test' ) {
  use Test;
  
  my @example1 = 
    ("opt", "bat", "saw", "tab", "pot", "top", "was").Array, 
    [ ("bat", "tab").Set, ("saw", "was").Set, ("top", "pot", "opt").Set ].Set
  ;
  my @example2 = 
    ("x").Array,
    [ ("x").Set ].Set;
  ;

  my @tests = @example1, @example2;
  @tests.map: { cmp-ok challenge($_[0]), '~~', $_[1] }

}
