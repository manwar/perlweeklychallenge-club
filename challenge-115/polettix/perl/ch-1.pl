#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub string_chain (@S) {
   my $start = shift @S;
   my ($sf, $sl) = (substr($start, 0, 1), substr($start, -1, 1));

   my %starting_with;
   push $starting_with{substr $_, 0, 1}->@*, [$_, 0] for @S;

   return unless exists $starting_with{$sl};
   my @chain = ([$starting_with{$sl}, -1]);

   LINK:
   while ('necessary') {
      my $top = $chain[-1];
      if ((my $i = $top->[-1]) < $top->[0]->$#*) {
         $top->[0][$i][1] = 0 if $i >= 0; # reset last iteration
         ++$i; # advance at least once
         ++$i while $i <= $top->[0]->$#* && $top->[0][$i][1];

         $top->[-1] = $i;
         redo LINK if $i > $top->[0]->$#*;

         my $last_letter = substr $top->[0][$i][0], -1, 1;
         if (@chain == @S) {
            if ($last_letter eq $sf) {
               return [
                  $start,
                  map {$_->[0][$_->[-1]][0]} @chain,
               ];
            }
         }
         else {
            $top->[0][$i][1] = 1; # mark this item
            if (my $sw = $starting_with{$last_letter}) {
               push @chain, [$sw, -1]; # "recurse"
            }
            else {
               return if $last_letter ne $sf;
            }
         }
      }
      elsif (@chain > 1) { pop @chain } # backtrack...
      else               { return     } # no luck...
   }
}

my @words = @ARGV ? @ARGV : qw< abc dea cd >;
if (my $chain = string_chain(@words)) {
   say 1;
   say {*STDERR} join ' ', $chain->@*;
}
else { say 0 }
