#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $N = 200_000;
my @extra = map { [$_ => 1] } split /\W+/, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque elementum diam et vulputate suscipit. Etiam cursus dictum dapibus. Aenean imperdiet augue vitae libero sollicitudin consectetur. Integer eu faucibus neque. Phasellus ultrices viverra est. Quisque feugiat velit eget nisi molestie, nec mattis arcu ornare. Duis feugiat mattis urna, in rhoncus nibh finibus non. Vestibulum viverra tellus sed purus hendrerit tristique. Etiam convallis fermentum tellus, in commodo tellus euismod eu. Sed semper non tellus vitae imperdiet. Duis feugiat lacinia pellentesque. Duis sodales varius magna ut lobortis. Etiam sit amet nisl et est tempus pretium. Nulla facilisi. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Quisque mollis varius elementum';
my @TESTS = (
  [ 'Perl',   1 ],
  [ 'TPF',    1 ],
  [ 'PyThon', 0 ],
  [ 'raku',   1 ],
  @extra,
);

is( capital($_->[0]), $_->[1] ) for @TESTS; warn "--1";
is( capital_split($_->[0]), $_->[1] ) for @TESTS; warn "--2";
is( capital_split_dot($_->[0]), $_->[1] ) for @TESTS; warn "--3";
is( capital_split_cap($_->[0]), $_->[1] ) for @TESTS; warn "--4";
is( capital_split_cdot($_->[0]), $_->[1] ) for @TESTS; warn "--5";
is( capital_neg($_->[0]), $_->[1] ) for @TESTS; warn "--6";
done_testing();

cmpthese($N,{
 'pos'       => sub { capital($_->[0])           for @TESTS },
 'split'     => sub { capital_split($_->[0])     for @TESTS },
 'split_dot' => sub { capital_split_dot($_->[0]) for @TESTS },
 'split_cdot' => sub { capital_split_cdot($_->[0]) for @TESTS },
 'split_cap' => sub { capital_split_cap($_->[0]) for @TESTS },
 'neg'       => sub { capital_neg($_->[0])       for @TESTS },
});

cmpthese($N,{
  'pos'         => sub { $_->[0] =~ m{^(?:[A-Z]+|[a-zA-Z][a-z]*)$}o                  ? 1 : 0 for @TESTS },
  'split'       => sub { $_->[0] =~ m{^[a-zA-Z][a-z]*$}o || $_->[0] =~ m{^[A-Z]+}o    ? 1 : 0 for @TESTS },
  'split_dot'   => sub { $_->[0] =~ m{^.[a-z]*$}o  || $_->[0] =~ m{^[A-Z]+}o          ? 1 : 0 for @TESTS },
  'split_cap'   => sub { $_->[0] =~ m{^[A-Z]+}o    || $_->[0] =~ m{^[a-zA-Z][a-z]*$}o ? 1 : 0 for @TESTS },
  'split_cdot'  => sub { $_->[0] =~ m{^[A-Z]+}o    || $_->[0] =~ m{^.[a-z]*$}o        ? 1 : 0 for @TESTS },
  'neg1'        => sub { $_->[0] =~ m{(?:[a-z][A-Z]|[A-Z]{2}[a-z])}o                  ? 0 : 1 for @TESTS },
  'neg'         => sub { $_->[0] =~ m{[a-z][A-Z]}o || $_->[0] =~ m{[A-Z]{2}[a-z]}o    ? 0 : 1 for @TESTS },
  'negx'        => sub { $_->[0] =~ m{[A-Z]{2}[a-z]}o ||  m{[a-z][A-Z]}o ? 0 : 1 for @TESTS },
});

## This shows an interesting aspect of the problem... There needs to be
## some domain knowledge. We
sub capital_split_dot {
  $_[0] =~ m{^.[a-z]*$} ||
  $_[0] =~ m{^[A-Z]+$} ? 1 : 0
}

sub capital {
  $_[0] =~ m{^(?:[A-Z]+|[a-zA-Z][a-z]*)$} ? 1 : 0
}

sub capital_split_cap {
  $_[0] =~ m{^[A-Z]+$}         ||
  $_[0] =~ m{^[a-zA-Z][a-z]*$} ? 1 : 0
}

sub capital_split_cdot {
  $_[0] =~ m{^[A-Z]+$}         ||
  $_[0] =~ m{^.[a-z]*$} ? 1 : 0
}

sub capital_split {
  $_[0] =~ m{^[a-zA-Z][a-z]*$} ||
  $_[0] =~ m{^[A-Z]+$} ? 1 : 0
}

sub capital_neg1 {
  $_[0] =~ m{(?:[a-z][A-Z]|[A-Z]{2}[a-z])} ? 0 : 1;
}

sub capital_negx {
  return 0 if $_[0] =~ m{[A-Z]{2}[a-z]};
  return 0 if $_[0] =~ m{[a-z][A-Z]};
  return 1;
}

sub capital_neg {
  return 0 if $_[0] =~ m{[a-z][A-Z]};
  return 0 if $_[0] =~ m{[A-Z]{2}[a-z]};
  return 1;
}

