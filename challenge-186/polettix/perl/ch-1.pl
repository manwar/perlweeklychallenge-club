#!/usr/bin/env perl
use v5.24;
use warnings;

sub zip(\@\@);

my @a = qw< 1 2 3 >;
my @b = qw< a b c >;
say "(@{[ zip(@a, @b) ]})";
say "(@{[ zip(@b, @a) ]})";
say "(@{[ lzip(@b, @a) ]})";
#say "(@{[ zip(@{[ @a, @b ]}) ]})";

sub zip (\@\@) {
   my ($A, $B) = @_;
   map { ($A->[$_], $B->[$_]) } 0 .. $A->$#*;
}

sub listy_zip {
   my @A = splice @_, 0, @_ / 2;
   map { ($A[$_], $_[$_]) } 0 .. $#_;
}
