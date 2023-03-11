#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say join ' ', grep { is_keyboard_word($_) } @ARGV;

sub is_keyboard_word ($word) {
   state $rows = [qw< qwertyuiop asdfghjkl zxcvbnm >];
   state $letter_sets = [
      map {
         +{ map { $_ => 1 } split m{}mxs }
      } $rows->@*
   ];
   state $set_idx_for = {
      map {
         my $idx = $_;
         map { $_ => $idx } split m{}mxs, $rows->[$idx];
      } 0 .. $rows->$#*
   };
   my @letters = split m{}mxs, lc($word);
   my $set_idx = $set_idx_for->{$letters[0]};
   my $set = $letter_sets->[$set_idx];
   for my $letter (@letters) {
      return '' unless exists($set->{$letter});
   }
   return 1;
}
