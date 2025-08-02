use strict; use warnings; use Test::More tests=>3;

sub has_even_vowel_count { 1 - pop =~ y/aeiouAEIOU// % 2 }

ok has_even_vowel_count( $$_{string} ) ? 'true' : 'false' eq $$_{output}
  for { string => "perl",         output => 'false' },
      { string => "book",         output => 'true' },
      { string => "good morning", output => 'true' }
