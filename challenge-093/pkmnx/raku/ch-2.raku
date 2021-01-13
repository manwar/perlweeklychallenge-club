#!/usr/bin/env raku
#
# see usage:
#
#  input is defined as show below: a hash as nodes with value key and
#     left ("l") and right ("r") children as nodes or leaves if no children.
#
#  see from given examples:
#
# my $h = {0 => {l => 2, r => 3}, 2 => {l => 4}, 3 => {l => 5, r => 6}}
# my $h = {1 => {l => 2}, 2 => {l => 3, r => 4}}
#

sub MAIN() {

   my $h = {1 => {l => 2, r => 3}, 2 => {l => 4}, 3 => {l => 5, r => 6}};

   my @st = ();
   my @all = ();
   fn($h, 1, @st, @all);

   my $sum = 0; 
   $sum += $_.sum for @all;

   "Input: ".say;
   $h.say;
   print "\n";

   my $sz = @all.elems;
   "Output: $sum".say;
   my $pth = @all.map({ "(" ~ $_.join("->") ~ ")" }).join(", ");
   "as sum $sz path(s) $pth".say;

}

sub fn($h, $nd, @st, @all) {

   @st.push($nd);

   my $cnt = 0;
   if ( $h{$nd}:exists ) {
      for ("l","r") -> $dir {
         if ( $h{$nd}{ $dir }:exists ) {
            my @st2 = ();
            @st.map({ @st2.push($_) });
            $cnt++;
            fn( $h, $h{$nd}{ $dir }, @st2, @all );
         }
      }
   }

   @all.push(@st) if $cnt == 0;

}
