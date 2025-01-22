#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub alien_dictionary{
  my ($words,$alien) = @_;
  my $r = join '',@$alien;
  sort{eval "\$a =~ tr/a-z/$r/r" cmp
       eval "\$b =~ tr/a-z/$r/r"} @$words
}

print show alien_dictionary(['perl','python','raku'],
			    [qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/]);
print show alien_dictionary(['the','weekly','challenge'],
			    [qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/]);

