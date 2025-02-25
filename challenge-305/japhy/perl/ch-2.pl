#!/usr/bin/perl -l

print join ", " => alien(["perl", "python", "raku"], [qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/]);
print join ", " => alien(["the", "weekly", "challenge"], [qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/]);

sub alien {
  my $D = join "", @{+pop};
  my $t = sub { local $_ = shift; eval "y/a-zA-Z/$D$D/"; $_ };
  return sort { $t->($a) cmp $t->($b) } @{+shift};
}
