#!/usr/bin/env raku
use v6;
use Test;

class LinkedList {
   my class LinkedListItem {
      has $.label is required;
      has $.succ is rw = Nil;
   }

   has $.head is rw = Nil;

   method create (::?CLASS:U $class: *@labels) {
      my $l = $class.new;
      @labels.reverse.map: {$l.insert($^label)};
      return $l;
   }

   method for-each (&cb) {
      my $p = self.head;
      while $p {
         &cb($p.label);
         $p = $p.succ;
      }
      return self;
   }

   method insert ($l) {
      self.head = LinkedListItem.new(label => $l, succ => self.head);
   }

   method Str () {
      my @labels;
      self.for-each({@labels.push: $^label});
      return @labels.join(' -> ');
   }

   method reverse () {
      my $r = LinkedList.new;
      self.for-each({$r.insert($^label)});
      return $r;
   }

   method add ($t) {
      my $ps = self.reverse.head;
      my $pt = $t.reverse.head;
      my $r = LinkedList.new;
      my $carry = 0;
      while defined($ps) || defined($pt) || $carry {
         my ($vs, $vt) = ($ps, $pt).map: -> $n is rw {
            (my $v, $n) = $n ?? ($n.label, $n.succ) !! (0, Nil);
            $v;
         }; # dirty dirty dirty
         my $v = $vs + $vt + $carry;
         ($v, $carry) = $v > 9 ?? ($v - 10, 1) !! ($v, 0);
         $r.insert($v);
      }
      return $r;
   }
}

multi sub infix:<+> (LinkedList:D $s, LinkedList:D $t) { $s.add($t) }

sub MAIN () {
   my @tests =
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
      ];

   for @tests -> $test {
      my ($tl1, $tl2, $texp) = @$test;
      my $len = $test.map({$^s.chars}).max;
      my $l1 = LinkedList.create($tl1.split: /\s* '->' \s*/);
      is $l1.Str, $tl1, sprintf("  (%{$len}s)", $tl1);
      my $l2 = LinkedList.create($tl2.split: /\s* '->' \s*/);
      is $l2.Str, $tl2, sprintf("+ (%{$len}s)", $tl2);
      my $sum = $l1 + $l2;
      is $sum.Str, $texp, sprintf("= (%{$len}s)", $texp);
   }
   done-testing;
}
