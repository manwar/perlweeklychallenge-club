#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use open qw/:std :utf8/;
use feature 'say';

use FindBin ();
use List::Util 1.33 qw/shuffle notall/;

use lib "$FindBin::Bin/lib";
use DeepL ();

# This script attempts to produce an English pangram
# that when translated to German is still a pangram.
# It uses DeepL to do the translation.

# You need to make an account for the free DeepL API to
# use it.

# See https://www.deepl.com/docs-api/translating-text/.

my @dictionary
  = do { open my $fh, '<', 'data/dictionary.txt' or die $!; <$fh>; };
chomp @dictionary;

my $translator
  = DeepL->new(auth_key => '0e2876de-3cee-2dad-b8b4-2df14894b2a6:fx');

while () {
  my @sentence   = get_pangram();
  my $english    = join ' ', @sentence;
  my $translated = $translator->translate($english);

  if (is_german_pangram($translated)) {
    say "English: " . $english;
    say "German:  " . $translated;
    last;
  }
}

# For the German pangram we are bending the rules a little. Very few words
# in German have Q, X or Y, so we allow umlauts instead. To make this stricter,
# increase the 26 to 29.
sub is_german_pangram {
  26 <= length(lc(join('', @_)) =~ s/[^a-zäöü]//gr =~ s/(.)(?=.*\1)//gr);
}

sub get_pangram {
  my %letters_seen;
  my @sentence;
  for my $word (shuffle @dictionary) {
    my @letters = split //, $word;
    next unless notall { exists $letters_seen{$_} } @letters;
    push @sentence, $word;
    $letters_seen{$_}++ for @letters;
    last if keys %letters_seen == 26;
  }

  return @sentence;
}

__END__
$ perl challenge-161/julien-fiegehenn/perl/ch-2-bonus.pl
English: emission sedans proclaimed duskier choppering phobia familiarity newborn convulsion sympathize jetted quells appendixes
German:  Emission Limousinen verkündet düsterer Zerhackungsphobie Vertrautheit neugeborener Krampf Sympathie gejettet quellt Anhängsel