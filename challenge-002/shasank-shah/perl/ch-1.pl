#! /usr/bin/perl
use v5.22;
say 'Casting with addition';
print 'Number? ';
say 0 + <>;

say 'Regex substitution';
print 'Number? ';
say <> =~ s/^0*(\d+)$/$1/r;

say 'Explicit integer casting';
print 'Number? ';
say int <>;

say 'Using map and a flip flop';
print 'Number? ';
say join '', map { /[^0]/ .. /\n/ ? $_ : () } split //, <>;
