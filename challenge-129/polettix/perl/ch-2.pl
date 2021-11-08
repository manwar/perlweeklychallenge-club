#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use Test::More;
use List::Util 'max';

for my $test (
   [
      '1 -> 2 -> 3',
      '3 -> 2 -> 1',
      '4 -> 4 -> 4',
   ],
   [
      '1 -> 2 -> 3 -> 4 -> 5',
      '6 -> 5 -> 5',
      '1 -> 3 -> 0 -> 0 -> 0',
   ],
   [
      '9 -> 8 -> 7',
      '1 -> 3',
      '1 -> 0 -> 0 -> 0',
   ],
) {
   my ($tl1, $tl2, $texp) = $test->@*;
   my $len = max map { length $_ } $test->@*;
   my $l1 = LinkedList->create(split m{\s*->\s*}mxs, $tl1);
   is $l1->stringify, $tl1, sprintf "  (%${len}s)", $tl1;
   my $l2 = LinkedList->create(split m{\s*->\s*}mxs, $tl2);
   is $l2->stringify, $tl2, sprintf "+ (%${len}s)", $tl2;
   my $sum = $l1 + $l2;
   is $sum->stringify, $texp, sprintf "= (%${len}s)", $texp;
}

done_testing();

package LinkedListItem;
use experimental 'signatures';
no warnings 'experimental::signatures';
sub label ($s, @n) { $s->{label} = $n[0] if @n > 0; $s->{label} }
sub new ($p, %s) { bless \%s, $p }
sub succ ($s, @n) { $s->{succ} = $n[0] if @n > 0; $s->{succ} }

package LinkedList;
use experimental 'signatures';
no warnings 'experimental::signatures';
use overload '+' => \&add;
sub create ($p, @labels) {
   my $l = $p->new;
   $l->insert($_) for CORE::reverse(@labels);
   return $l;
}
sub for_each ($self, $cb) {
   my $p = $self->{head};
   while (defined $p) {
      $cb->(local $_ = $p->label);
      $p = $p->succ;
   }
   return $self;
}
sub insert ($self, $l) {
   $self->{head} = LinkedListItem->new(label => $l, succ => $self->{head});
   return $self;
}
sub new ($p, %s) { bless {head => undef, %s}, $p }
sub stringify ($s) {
   my @labels;
   $s->for_each(sub {push @labels, $_});
   return join ' -> ', @labels;
}
sub reverse ($self) {
   my $r = LinkedList->new;
   $self->for_each(sub {$r->insert($_)});
   return $r;
}
sub add ($s, $t, @ignore) {
   my $ps = $s->reverse->{head};
   my $pt = $t->reverse->{head};
   my $r = LinkedList->new;
   my $carry = 0;
   while (defined($ps) || defined($pt) || $carry) {
      my ($vs, $vt) = map {
         (my $v, $_) = $_ ? ($_->label, $_->succ) : (0, undef);
         $v;
      } ($ps, $pt);
      my $v = $vs + $vt + $carry;
      ($v, $carry) = $v > 9 ? ($v - 10, 1) : ($v, 0);
      $r->insert($v);
   }
   return $r;
}
