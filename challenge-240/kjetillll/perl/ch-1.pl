use v5.10; use strict; use warnings;

sub is_acronym { lc pop   eq   lc "@_"=~s/(\S)\S*\s*/$1/gr }

for my $test (
  { str => ["Perl", "Python", "Pascal"],  chk => "ppp",   output => 1 },
  { str => ["Perl", "Raku"],              chk => "rp",    output => 0 },
  { str => ["Oracle", "Awk", "C"],        chk => "oac",   output => 1 }
)
{ say is_acronym( @{ $$test{str} }, $$test{chk} ) == $$test{output} ? '✓' : '☠' }
