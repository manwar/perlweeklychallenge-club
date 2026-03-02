#!/usr/bin/env perl
use v5.40;

use Getopt::Long;
use Lingua::Any::Numbers qw( :standard );
use List::AllUtils qw( none );
use Locale::Codes::Language;

binmode STDOUT, ":utf8";

my $help = 0;
my $lang = 'EN';
GetOptions
  'language=s' => \$lang,
  'help|?'     => \$help
;
my $bad_language = none { $lang eq $_ } available;
if ($help || $bad_language ) {
  my $language = code2language($lang) // ''; # translate language code
  $language = " ($language)" if $language; # wrap in parens if defined
  say "unknown language: $lang$language" if $bad_language;
  say "usage: $0 [--language=XX] [--help | -?]\n";
  say "Avalable languages:";
  foreach my $code (available) {
    say " * $code - ".code2language($code);
  }
  exit;
}

sub spellbound($lang, @nums) {
  my %words_to_num = map { to_string($_, $lang) => $_} @nums;
  my @wordlist = sort { fc($a) cmp fc($b) } keys %words_to_num;
  return (
    join(', ', @wordlist),
    map { $words_to_num{$_} } @wordlist
  );
}

sub solution($nums) {
  say 'Input: (' . join(', ', @$nums) . ')';
  my ($words, @sorted) = spellbound($lang, @$nums);
  say 'Output: (' . join(', ', @sorted) . ')';
  my $language = code2language($lang);
  say "\n$language: $words";
}

say "Example 1:";
solution([6, 7, 8, 9, 10]);

say "\nExample 2:";
solution([-3, 0, 1000, 99]);

say "\nExample 3:";
solution([1, 2, 3, 4, 5]);

say "\nExample 4:";
solution([0, -1, -2, -3, -4]);

say "\nExample 5:";
solution([100, 101, 102]);
