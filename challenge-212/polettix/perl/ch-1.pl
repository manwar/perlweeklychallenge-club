#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

my ($word, @jumps) = @ARGV ? @ARGV : qw< Perl 2 22 19 9 >;
say jumping_letters($word, @jumps);

sub jumping_letters ($word, @jumps) {
   state $bases = [ord('A'), ord('a')];
   join '', map {
      my $old = ord(substr($word, $_, 1));
      my $base = $bases->[$old >= $bases->[1]];
      my $new = $base + (($old - $base + $jumps[$_]) % 26);
      chr($new);
   } 0 .. $#jumps;
}
