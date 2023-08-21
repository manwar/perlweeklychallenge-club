#!/usr/bin/env raku

use v6;

use Lingua::Conjunction;
use Lingua::EN::Numbers;

sub quoted_list ( *@list ) {
  # given a list, quote the elements and join them with commas
  my @quoted = @list.map: { qq{"$_"} };
  return @quoted.join(q{, });
}

sub solution (Str $prefix, *@words where {$_.all ~~ Str}) {
  say qq{Input: \@words  = (} ~ quoted_list(@words) ~ q{)};
  say qq{       \$prefix = "$prefix"};

  my @matched;
  for @words -> $word {
    # "next unless" is a raku idiom, too
    next unless $word ~~ /^$prefix/;
    push @matched, $word;
  }
  my $count = @matched.elems;
  say "Output: $count";
  say "";

  # the examples show the word count in English as well, so
  # let's use the Lingua::EN::Numbers module
  my $count_en = tclc cardinal($count);

  # also, let's inflect the words 'word' and 'start'
  #
  # The documentation for Lingua::Conjunction says "You can use 
  # special sequence [|] (e.g. octop[us|i]) where string to the
  # left of the | will be used when the list contains just one
  # item and the string to the right will be used otherwise."
  # but there's a bug where it uses the left when there is one
  # OR TWO items.
  #
  # I've fixed it and created a pull request
  # https://github.com/raku-community-modules/Lingua-Conjunction/pull/2
  my $str = qq{$count_en word[|s] |list| start[s|] }
          ~ qq{with the given prefix "$prefix".};
  my @quoted = @matched.map: { qq{"$_"} };
  say conjunction @quoted, :$str;
}

say "Example 1:";
solution("at", "pay", "attention", "practice", "attend");

say "";

say "Example 2:";
solution("ja", "janet", "julia", "java", "javascript");