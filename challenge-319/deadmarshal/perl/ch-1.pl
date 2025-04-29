#!/usr/bin/env perl
use strict;
use warnings;

sub word_count{
  scalar grep {/^[aeiou]|[aeiou]$/} @{$_[0]}
}

printf "%d\n",word_count(["unicode","xml","raku","perl"]);
printf "%d\n",word_count(["the","weekly","challenge"]);
printf "%d\n",word_count(["perl","python","postgres"]);

