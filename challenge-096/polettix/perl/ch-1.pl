#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub reverse_words ($S) {
   join(' ', reverse split m{\s+}mxs, $S) =~ s{\s+\z}{}rmxs;
}

my $input = join(' ', @ARGV)
   || '    Perl and   Raku are  part of the same family  ';
say '<', reverse_words($input), '>';
