#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use Test::More;

sub canonical_path ($p) {
   $p =~ s{/\K(?:\.?/)+}{}gmxs;
   $p =~ s{\A/.*\K/\z}{}mxs;
   1 while $p =~ s{/[^/]+/\.\.(/|\z)}{$1}mxs;
   return $p;
}

for my $test(
   [qw< /a/ /a >],
   [qw< /a//b/c/ /a/b/c >],
   [qw< /a/b/c/../.. /a >],
   [qw< /a/b/c/../../ /a >],
   [qw< /a/./b/.//./c/../../ /a >],
   [qw< /a/../../../b/ /b >],
) {
   my ($input, $expected) = $test->@*;
   my $got = canonical_path($input);
   is $got, $expected, "'$input' -> '$expected'";
}

done_testing;
