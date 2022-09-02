#!/usr/bin/env raku
use v6;

sub trim (&cond, *@items) { grep {! &cond($_) }, @items }
sub trim_le ($i, *@items) { trim {$_ <= $i}, @items }

sub MAIN ($i is copy = Nil, *@args) {
   ($i, @args) = 3, 1, 4, 2, 3, 5 unless defined $i;
   my @trimmed = trim_le($i, @args);
   put '(' ~ @trimmed.join(',') ~ ')';
}
