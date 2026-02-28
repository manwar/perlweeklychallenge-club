#!/usr/bin/env raku
use v6;

use Getopt::Long;
use Lingua::NumericWordForms;

get-options(
  'language=s' => my $lang,
  'help|?'     => my $help,
  auto-abbreviate => True,
);
$lang //= 'english'; # default language
my @available = from-numeric-word-form('languages').sort;
my $bad_language = $lang.lc eq @available.none;
if ($help || $bad_language ) {
  say "unknown language: $lang" if $bad_language;
  say "usage: $*PROGRAM [--language=XX] [--help | -?]\n";
  say "Avalable languages:";
  for @available -> $code {
    say " * " ~ $code.tc;
  }
  exit;
}

# Lingua::NumericWordForms does not handle negative numbers!
# so we have to wrap the to-numeric-word-form and massage the
# output so it has the appropriate prefix
&to-numeric-word-form.wrap(
  sub ($num, $lang) {
    nextsame if $num >= 0;
    my $minus = do given $lang.lc {
      when 'armenian'    { 'բացասական ' }
      when 'azerbaijani' { 'mənfi ' }
      when 'azərbaycan'  { 'mənfi ' }
      when 'bulgarian'   { 'минус ' }
      when 'český'       { 'mínus ' }
      when 'czech'       { 'mínus ' }
      when 'deutsch'     { 'minus ' }
      when 'français'    { 'moins ' }
      when 'french'      { 'moins ' }
      when 'german'      { 'minus ' }
      when 'greek'       { 'μείον ' }
      when 'japanese'    { 'マイナス' }
      when 'kazakh'      { 'минус ' }
      when 'korean'      { '마이너스 ' }
      when 'koremutake'  { 'minus ' }
      when 'qazaq'       { 'минус ' }
      when 'казак'       { 'минус ' }
      when 'қазақ'       { 'минус ' }
      when 'ελληνικά'    { 'μείον ' }
      when 'български'   { 'минус ' }
      when 'Հայերեն'     { 'բացասական ' }
      when '한국어'        { '마이너스 ' }
      when '日本語'       { 'マイナス' }
      when 'persian'     { 'منها ' }
      when 'polish'      { 'minus ' }
      when 'polski'      { 'minus ' }
      when 'portuguese'  { 'menos ' }
      when 'português'   { 'menos ' }
      when 'romanian'    { 'minus ' }
      when 'română'      { 'minus ' }
      when 'russian'     { 'минус ' }
      when 'руский'      { 'минус ' }
      when 'spanish'     { 'menos ' }
      when 'español'     { 'menos ' }
      when 'ukrainian'   { 'мінус ' }
      when 'український' { 'мінус ' }
      default            { 'negative ' }
    };
    $minus ~ callwith(abs($num), $lang);
  }
);

sub spellbound($lang, @nums) {
  my %words_to_num = @nums.map({
    to-numeric-word-form($_, $lang) => $_
  });
  my @wordlist = %words_to_num.keys.sort: *.fc;
  return (
    @wordlist.join(", "),
    @wordlist.map( { %words_to_num{$_} } )
  );
}

sub solution(@nums) {
  say 'Input: (' ~ @nums.join(', ') ~ ')';
  my ($words, $sorted) = spellbound($lang, @nums);
  say 'Output: (' ~ $sorted.join(', ') ~ ')';
  say "\n$lang: $words";
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

