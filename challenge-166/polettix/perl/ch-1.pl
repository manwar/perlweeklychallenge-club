#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use File::Spec::Functions qw< splitpath splitdir catdir catpath >;

my $max_subs = shift // 8;

my ($v, $dirs, $file) = splitpath(__FILE__);
$dirs = catdir(splitdir($dirs), split m{/}mxs, '../../../data');
$file = catpath($v, $dirs, 'dictionary.txt');
say "0x$_" for hexadecimal_words_from($file, $max_subs);

sub hexadecimal_words_from ($file, $max_subs) {
   open my $fh, '<:encoding(UTF-8)', $file or die "open('$file'): $!\n";
   map { hexadecimal_word($_, $max_subs) } <$fh>;
}

sub hexadecimal_word ($candidate, $max_subs = 8) {
   state $HEX_LETTERS = { map { $_ => 1 } 'a' .. 'f' };
   state $DIGIT_FOR = { qw< o 0 i 1 l 1 s 5 t 7 > };
   $candidate =~ s{\s+}{}gmxs;
   my @retval;
   for my $char (split m{}mxs, $candidate) {
      if (exists $HEX_LETTERS->{$char}) { push @retval, $char; next }
      return unless exists $DIGIT_FOR->{$char};
      return if --$max_subs < 0;
      push @retval, $DIGIT_FOR->{$char};
   }
   return join '', @retval;
}
