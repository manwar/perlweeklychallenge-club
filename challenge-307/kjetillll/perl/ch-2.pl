
sub caar { #count after anagram removals
    my $words = join ' ', map join('',sort/./g), @_;
    1 while $words =~ s/\b(\w+) \1\b/$1/;
    0 + split / /, $words;    
}


use Test::More tests => 2;
is caar(@{$$_{words}}), $$_{output} for
  {words=>["acca", "dog", "god", "perl", "repl"],output=>3},
  {words=>["abba", "baba", "aabb", "ab", "ab"],output=>2};
