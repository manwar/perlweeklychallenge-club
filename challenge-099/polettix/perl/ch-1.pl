#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub pattern_match ($S, $T) {
   $T = join '',
      map { $_ eq '*' ? '.*' : $_ eq '?' ? '.' : quotemeta($_) }
      split m{([*?])}mxs, $T;
   return $S =~ m{\A$T\z}mxs ? 1 : 0;
}

my $string = shift // 'abcde';
my $pattern = shift // 'a*e';
say pattern_match($string, $pattern);
