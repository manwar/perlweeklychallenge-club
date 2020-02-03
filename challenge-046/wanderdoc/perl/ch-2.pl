#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
There are 500 rooms in a hotel with 500 employees having keys to all the rooms. The first employee opened main entrance door of all the rooms. The second employee then closed the doors of room numbers 2,4,6,8 ,10 and so on to 500. The third employee then closed the door if it was opened or opened the door if it was closed of rooms 3,6,9,12,15 and so on to 500. Similarly the fourth employee did the same as the thir d but only room numbers 4,8,12,16 and so on to 500. This goes on until all employees has had a turn.
Write a script to find out all the rooms still open at the end.
=cut

use constant {NUM => 500, OPEN => 1, SWITCH => -1};
use Benchmark qw(:all);



# In two ways (theory to the 'logic' way see below):

cmpthese(-1, {
    'model' => \&model,
    'logic' => \&logic,
});



=output
With print:

        Rate model logic
model 51.7/s    --  -60%
logic  130/s  151%    --

With print commented out:

        Rate model logic
model 53.2/s    --  -60%
logic  133/s  150%    --
=cut





sub model
{
     my @hotel = (OPEN) x NUM;
     unshift @hotel, 'Lobby'; # to make the array indices equal to room numbers.

     for my $emp ( 2 .. NUM )
     {
          @hotel[ grep $_ % $emp == 0, $emp .. NUM ] =
               map $_ * SWITCH, @hotel[ grep $_ % $emp == 0, $emp .. NUM ];
     }

     my @open = grep $hotel[$_] == OPEN, 1 .. NUM;

     # print join(" ", @open), $/; # 1 4 9 16 25 36 49 64 81 100 121 144 169 196 225 256 289 324 361 400 441 484
}



=theory
First, all rooms are open. The room 1 remains open. The other rooms remain open at the end if they were closed and re-opened even number of times. That means, for the numbers from 2 upwards we could search for the numbers that have an even number of delimiters.
=cut

sub logic
{
     my @OPEN = (1);
     for ( 2 .. NUM ) { push @OPEN, $_ if (is_open($_)); } 

     sub is_open
     {

          my $n = $_[0];
          my $counter = 0;
          for my $k ( 2 .. $n )
          {
               0 == $n % $k and $counter++;
          }
          return $n if $counter % 2 == 0;
     }

     # print join(" ", @OPEN), $/; # 1 4 9 16 25 36 49 64 81 100 121 144 169 196 225 256 289 324 361 400 441 484
}