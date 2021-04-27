#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub transpose_file ($f) {
   $f = ref($f)     ? $f
      : ($f eq '-') ? \*STDIN
      :               do { open my $h, '<', $f or die "$!\n"; $h };
   my @lines = map { chomp; [ split m{,}mxs ] } <$f>;
   while ('necessary') {
      my $g = 0;
      my @t = map { $g = 1 if $_->@*; shift($_->@*) || '' } @lines;
      last unless $g;
      say join ',', @t;
   }
   return;
}

my $f = shift // do {
   my $input = <<'END';
name,age,sex
Mohammad,45,m
Joe,20,m
Julie,35,f
Cristina,10,f
END
   open my $fh, '<', \$input;
   $fh;
};

transpose_file($f);
