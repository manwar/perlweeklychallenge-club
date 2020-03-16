#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Suppose there are following coins arranged on a table in a line in random order.
    £1, 50p, 1p, 10p, 5p, 20p, £2, 2p
Suppose you are playing against the computer. Player can only pick one coin at a time from either ends. Find out the lucky winner, who has the larger amounts in total?
=cut





use utf8;
use List::Util qw(shuffle sum reduce);
my %money = ( '£1' => 100, '50p' => 50, 
              '1p' => 1, '10p' => 10, 
              '5p' => 5, '20p' => 20, 
              '£2' => 200, '2p' => 2 );
my %values = reverse %money;

my %result;



for my $i ( 1 .. 1_000 )
{
     my @set = shuffle keys %values; # :-)
     my %players = (PC => [], ME => [],);
     while ( @set )
     {
          for my $player ( sort {$b cmp $a} keys %players ) # PC first.
          {
               if ( $set[0] > $set[-1] )
               {
                    push @{$players{$player}}, shift @set;
               }


               else
               {
                    push @{$players{$player}}, pop @set;
               }
          }
     }

     my $winner = reduce { sum(@{$players{$a}}) > sum(@{$players{$b}}) ? $a : $b } keys %players;

     $result{$winner}++;
}
print "$_ => $result{$_}$/" for keys %result;