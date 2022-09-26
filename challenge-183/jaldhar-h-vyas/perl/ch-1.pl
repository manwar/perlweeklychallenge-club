#!/usr/bin/perl
use 5.030;
use warnings;

sub unique {
  my %seen;
  return grep { !$seen{join q{}, @{$_}}++ } @_;
}

sub printUnique {
    say
        q{(},
        (join q{, }, map { q{[} . (join q{,}, @{ $_ }) . q{]} } unique( @_ )),
        q{)};
}

my @list1 = ([1,2], [3,4], [5,6], [1,2]);

printUnique(@list1);

my @list2 = ([9,1], [3,7], [2,5], [2,5]);

printUnique(@list2);
