#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
use Data::Dumper;

my ($best, $trail) = box_coins(@ARGV);
say {*STDERR} Dumper($trail);
say $best;

sub box_coins (@box) {
   local $" = ' ';

   return (0, []) unless @box;
   return ($box[0],
      [{input => "(@box)", take => 0, score => $box[0], left => '()'}])
     if @box == 1;

   my $best  = 0;
   my $trail = [];
   my @pre;
   my @post = @box;
   while (@post) {
      my $item = shift @post;
      my ($run, $windown) = __SUB__->(@pre, @post);
      my $val = (@pre ? $pre[-1] : 1) * $item * (@post ? $post[0] : 1);
      $run += $val;
      if ($run > $best) {
         $best  = $run;
         $trail = [
            {
               input => "(@box)",
               take  => scalar(@pre),
               score => $val,
               left  => "(@{[@pre, @post]})",
            },
            $windown->@*
         ];
      } ## end if ($run > $best)
      push @pre, $item;
   } ## end while (@post)

   return ($best, $trail);
} ## end sub box_coins
