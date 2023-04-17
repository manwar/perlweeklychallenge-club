use strict;
use warnings;
use v5.36;

use Test::More;

# alphabet code with 'a' as 0
sub normalize_letter_code ($letter) {
  return ord($letter) - ord('a');
}

# return to its ASCII char form
sub denormalize_letter_code ($normalized_letter_code) {
  return chr($normalized_letter_code + ord('a'));
}

my $alphabet_length = normalize_letter_code('z') + 1;

sub jump_letters ($word, @jumps) {
  die '$word must have as much letters as @jumps\' size!' unless length $word == @jumps;
  my $jumpsIndex = 0;
  return join '', map {
    my $is_upper_case = uc($_) eq $_;
    my $letter = lc($_);
    my $new_letter = denormalize_letter_code((normalize_letter_code($letter) + $jumps[$jumpsIndex++]) % $alphabet_length);
    $new_letter = uc($new_letter) if $is_upper_case;
    $new_letter;
  } split //, $word
}

is jump_letters('Perl', (2, 22, 19, 9)), 'Raku';
is jump_letters('Raku', (24, 4, 7, 17)), 'Perl';

done_testing;
