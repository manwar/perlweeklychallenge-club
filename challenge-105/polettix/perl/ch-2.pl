#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub the_name_game ($name) {
   my ($first, $Y) = $name =~ m{\A([^aeiouy]?)(.*)}mxs;
   $first = lc $first;
   return join "\n",
      "$name, $name, bo-" . ($first eq 'b' ? $Y : "b$Y"),
      "Bonana-fanna fo-"  . ($first eq 'f' ? $Y : "f$Y"),
      "Fee fi mo-"        . ($first eq 'm' ? $Y : "m$Y"),
      "$name!";
}

my $n = shift || 'Katie';
say the_name_game($n);
