#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub list_methods ($module) {
   no strict 'refs';
   return grep { defined &{$module . '::' . $_} } keys %{$module . '::'};
}

sub load ($module) { require("$module.pm" =~ s{::}{/}grmxs); $module }

use FindBin '$Bin';
use lib $Bin;;
my $module = shift // 'Calc';
say for list_methods(load($module));
