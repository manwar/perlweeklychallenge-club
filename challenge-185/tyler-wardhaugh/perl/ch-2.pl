#!/usr/bin/env perl

use v5.36;
use builtin qw(indexed);
use Data::Dumper qw(Dumper);
$Data::Dumper::Terse = 1;


our @TESTS = (
  [['ab-cde-123', '123.abc.420', '3abc-0010.xy'], ['xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy']],
  [['1234567.a', 'a-1234-bc', 'a.b.c.d.e.f'], ['xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f']],
);


sub mask($code) {
  state $MASKABLE = qr/[a-z0-9]/i;
  state $UNMASKABLE = qr/([^a-z0-9]*)/i;
  state $MASK_RE = join $UNMASKABLE, ($MASKABLE) x 4;

  $code =~ s/$MASK_RE/x$1x$2x$3x/r;
}


sub main($args) {
  foreach my $codes ($args->@*) {
    say Dumper([map { mask($_) } $codes->@*]);
  }
}


sub test() {
  use builtin qw(indexed);
  use experimental qw(for_list);
  use Test2::V0;
  no warnings qw(experimental);

  plan scalar @TESTS;

  foreach my ($i, $case) (indexed @TESTS) {
    my ($input, $expected) = $case->@*;
    is [map { mask($_) } $input->@*], $expected, 'Test ' . ++$i;
  }
}


exit test() if (@ARGV && $ARGV[0] eq '--test');
exit main(@ARGV and [\@ARGV] or [map { $_->[0] } @TESTS]);
