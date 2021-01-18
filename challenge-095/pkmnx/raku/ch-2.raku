#!/usr/bin/env raku


class Stack {

   has @!d;
   has %!h;

   method !place($n) {

      my $hV = %!h{ %!h{'head'} }{'v'};

      if ( $n <= $hV ) {
         %!h{$n}{'n'} = $hV;
         %!h{ %!h{'head'} }{'p'} = %!h{$n}{'v'};
         %!h{'head'} = %!h{$n}{'v'};
      } else {
         my $isSearch = True;
         my $nHV = $hV;
         my $placeCnt = 0;
         my $last;
         while ( $isSearch ) {  ## could make faster w/ bin. srch, but would need min & max and diff store, maybe
            $last = $nHV;
            $nHV = %!h{$nHV}{'n'};
            if ( $nHV.defined ) {
               if ( $n < $nHV ) {
                  %!h{$last}{'n'} = $n;
                  %!h{$n}{'p'} = $last;
                  %!h{$n}{'n'} = $nHV;
                  %!h{$nHV}{'p'} = $n;
                  $placeCnt++;
                  $isSearch = False;
               }
            } else {
               $isSearch = False;
            }
         }
         if ( $placeCnt == 0 ) {
            %!h{$n}{'p'} = $last;
            %!h{$last}{'n'} = $n;
         }
      }
   }

   method push($n) {

      @!d.push($n);

      if ( %!h{$n}:!exists ) {
         %!h{$n} = { v => $n, n => Nil, p => Nil };
      }

      if ( %!h{'head'}:!exists ) {
         %!h{'head'} = %!h{$n}{'v'};
      } else {
         self!place($n);
      }

   }

   method pop() { self!removeTail }
   method top() { return @!d.tail }

   method min() {
      if ( %!h{'head'}.defined ) { 
         return %!h{%!h{'head'}}{'v'}
      }
   }

   method !removeTail() {

      if ( @!d.defined && @!d.elems > 0 ) {
         my $t = @!d.pop;

         my $p = %!h{$t}{'p'};
         my $n = %!h{$t}{'n'};

         %!h{$t}:delete;
         if ( $p.defined ) { %!h{$p}{'n'} = $n }
         if ( $n.defined ) { %!h{$n}{'p'} = $p }

         if ( $t ~~ %!h{'head'} ) {
            if ( $n.defined ) {
               %!h{'head'} = $n;
            } else {
               %!h{'head'}:delete
            }
         }
      }

   }

}

sub MAIN() {

   my $stack = Stack.new();

   $stack.push(2);
   $stack.push(-1);
   $stack.push(0);
   $stack.pop;       # removes 0
   say $stack.top;   # prints -1
   $stack.push(0);
   say $stack.min;   # prints -1

}
