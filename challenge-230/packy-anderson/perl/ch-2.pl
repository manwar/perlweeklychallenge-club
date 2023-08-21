#!/usr/bin/env perl

use v5.38;

use Lingua::EN::Inflexion qw( inflect wordlist );

sub quoted_list {
  # given a list, quote the elements and join them with commas
  my @quoted = map { qq{"$_"} } @_;
  return join q{, }, @quoted;
}

sub solution {
  my $prefix = shift;
  my @words  = @_;
  say qq{Input: \@words  = (} . quoted_list(@words) . q{)};
  say qq{       \$prefix = "$prefix"};

  my @matched;
  foreach my $word ( @words ) {
    # "next unless" is a perl idiom
    next unless $word =~ /^$prefix/;
    push @matched, $word;
  }
  my $count = scalar(@matched);
  say "Output: $count";
  say "";

  # put the list of words into an English list using "and"
  my $wordlist = wordlist( map { qq{"$_"} } @matched );

  # let's inflect the words 'word' and 'start'
  say ucfirst inflect qq{<#w:$count> <N:word> $wordlist "
    . "<V:start> with the given prefix "$prefix".};
}

say "Example 1:";
solution("at", "pay", "attention", "practice", "attend");

say "";

say "Example 2:";
solution("ja", "janet", "julia", "java", "javascript");