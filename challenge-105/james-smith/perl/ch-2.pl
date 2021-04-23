#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my $TEMPLATE = '%1$s, %1$s, bo-%3$s%2$s
Bonana-fanna fo-%4$s%2$s
Fee fi mo-%5$s%2$s
%1$s!

';
my $REGEX = '^[aeiou]*([bcdfghjklmnpqrstvwxyz])';

print map { the_name_game( $_ ) } qw(Katie Lucy James Bob Fred Mike Aaron Abel);
#done_testing();

sub the_name_game {
  return sprintf $TEMPLATE, $_[0], $_[0]=~s{$REGEX}{}ri, map { $_ eq lc $1?'':$_ } qw(b f m);
}

