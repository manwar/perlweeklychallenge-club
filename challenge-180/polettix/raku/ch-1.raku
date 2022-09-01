#!/usr/bin/env raku
use v6;

class DoubleLinkedList { ... }
sub MAIN ($string = 'Perl Weekly Challenge') {
   my $order = DoubleLinkedList.new;
   my %dll-element-for;
   my $i = 0;
   for $string.comb -> $character {
      if %dll-element-for{$character}:exists {
         if defined %dll-element-for{$character} {
            $order.remove(%dll-element-for{$character});
            %dll-element-for{$character} = Nil;
         }
      }
      else {
         %dll-element-for{$character} = $order.push($i).tail;
      }
      ++$i;
   }

   die 'no result, sorry!' unless defined $order.head;
   put $order.head.value;
}

class DoubleLinkedList {
   class Element {
      has $.value;
      has $.pred is rw is built = Nil;
      has $.succ is rw is built = Nil;
   }

   has $.head is rw is built = Nil;
   has $.tail is rw is built = Nil;

   method push ($value) {
      my $element = Element.new(
         value => $value, pred => $.tail, succ => Nil);
      $.tail.succ = $element if defined $.tail;
      $.tail = $element;
      $.head //= $element;
      return self;
   }

   method remove ($element) {
      if (defined $element.pred) {
         $element.pred.succ = $element.succ;
      }
      else {
         $.head = $element.succ;
      }
      if (defined $element.succ) {
         $element.succ.pred = $element.pred;
      }
      else {
         $.tail = $element.pred;
      }
      return self;
   }
}
