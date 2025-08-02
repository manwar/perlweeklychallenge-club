use strict; use warnings; use List::Util 'max'; use Test::More tests => 4;

sub size_largest_block {
  my $width = 0 + @{ $_[0] };                     #width = length or first array
  my @matrix = map @$_, @_;                       #flatten the list of lists in the input into just one long list
  my @group;                                      #array of same length (eventually) to keep group id's for each cell
  for my $i ( 0 .. $#matrix ){                    #loop through the $i integer index of cells in the matrix
    my @visit = ($i);                             #to be visited
    while( @visit ){                              #while more cells to visit (flood fill algorithm)
      my $v = shift @visit;                       #$v = index of current visited cell
      next if defined $group[$v];                 #skip if already visted (cell has been assigned a group)
      next if $matrix[$v] ne $matrix[$i];         #skip if not same letter x or o as $i
      $group[$v] = $group[$i] //= $i;             #set group of visited cell to the same as that of the current $i cell which is
                                                  #...assigned a new group id unless it already has one (by just using $i as group id's)
      push @visit,                                #register neighbors to visit
          $v % $width           ? $v-1      : (), #has left neighbor? if so visit it
          ($v+1) % $width       ? $v+1      : (), #has right neighbor? if so visit it
          $v-$width >= 0        ? $v-$width : (), #has above neighbor? if so visit it
          $v+$width <= $#matrix ? $v+$width : ()  #has below neighbor? if so visit it
    }
  }
  my %freq; $freq{$_}++ for @group;               #count group id frequencies
  max values %freq;                               #return highest count
}

is size_largest_block(
  ['x', 'x', 'x', 'x', 'o'],
  ['x', 'o', 'o', 'o', 'o'],
  ['x', 'o', 'o', 'o', 'o'],
  ['x', 'x', 'x', 'o', 'o'] ) => 11;

is size_largest_block(
  ['x', 'x', 'x', 'x', 'x'],
  ['x', 'o', 'o', 'o', 'o'],
  ['x', 'x', 'x', 'x', 'o'],
  ['x', 'o', 'o', 'o', 'o'] ) => 11;

is size_largest_block(
  ['x', 'x', 'x', 'o', 'o'],
  ['o', 'o', 'o', 'x', 'x'],
  ['o', 'x', 'x', 'o', 'o'],
  ['o', 'o', 'o', 'x', 'x'] ) => 7;

is size_largest_block(map[/./g],<<""=~/\w+/g) => 150;
  xoxxxxxoxxooooxxxxxxooooxoxxxoxoxxxooxoooxoxoxoxxoxoxxoooxxxxoxoooxxxx
  oooxxooxxxxooxoxxoxxooxoxxxooxxxoxooxooooxxxxooxoxxxooooxxxxxxxxxoxxxo
  ooxoxooooxxxoxxoooxxxooxooxooooooxoxxooooooxoooxxxxxxxoxoxoxxxoxxxxoxx
  oxoxoxoxoxooxxoxxxxoooxooxxoxxxoxoxoxxxxoxoxooxooxxooxxxoxxooxxoooxxoo
  xxxooxxxoxxxxoxoxxxxxxxxxxxoxoxooxoxxooxxxxoxxooxoooxxooxxxxxxxxoxxxxo
  xooxooooxooxxoooooooxxxoooxooxooxxoxxoxoxoooxxxooxxxoxxxxxooxxoxooxoxx
  xxooooooxxoxxoxxoooxoxxoxxxxooxooxoooxxxxxooxxxoxooooxxxoooxoxxxxxxoxx
  xoxooxxoxoooxxoxxxoooxoxoxxxooooxoxooxxoxoxxxooxoxxoxooooooxoxooxxxoxx
  xxxooxxxooxxxooxoooxoooxooooxxxxxoxxoxxoxxxoooxxoxoxoxxxooooxxoxooooox
  xoxxooxxoxxoxoooxxxooxoxxoooxooxxoxoxxxooxoxxooooxoxxxxxooxoxxoxoxxxoo
  xxxoooxoxooxxxooxoxxxoxoxoooxoxooooxoxxoxoooooxooooxooooxxoxxxooooooxx
  oxoxooooxxxxooxxxxoxoxxxooooxxoooxxxooxxxxxxooxxxxoooxxxxoxxoxxoooxooo
  oxxxxooxooxxoxooxoxooxoxoxooxoxooxxxoooooxoooxxxxooxxoxxooxoxooxooxxoo
  xxxxxxooxxxoxxxxoooxxooxxxxxooxxxxxoooxxoxxoxoxxxxxoxxoxoxoooxoxxxxxox
  xooxooxooxooxooxxoxxoxxxoxooooxooxxoxoxxoxxoooxooxxxoooxooxoxoooxxxxoo
  oxxxoooxxxxooxoxxooxooxoxxooxoxxxoxoxoxxxoxooxxxxoxoxxooooxooooxxxoxox
  xxooxoxxxxooxoxoooxxxxooooooooxoooxxoxxxxooxoxxoxoxxoxoooxoxxxxxxxxxoo
  xxxxxoxxoxoxoxxxoxoooxxxooxxxxxxxoooxxoxoxoxxooxxoxxoxxoxooxoxoxxxxxoo
  xxoxxoxxxxoxoxxxxxooxoooxxoxooxoooooxxoxxoxoooxoxxooooxoxoooxoooooooxx
  ooooxxxooxooxooooxxoxoxxoxoooxxooxoxoxxxooxoxxooxoxxoxoooxxxoxxxxooxoo
  oooxoxxoxoooxxxxxxoooxooxxxoooxooxxoxxxooxoxxoxxxoxooooxxoxxooxooooxxx
  xoxooxxxoxoxxxxxooxoxooxxxxxxooxxxooooooxxxoxoxooxxoxoxxxoooxxxxxxxooo
  ooxxooxxxoxxxooxxoooxxxoxooxxxxxxxxooxoxoooxxoxxxxoxxxxoxxoooxxooooxox
  xoxxoxxxxooooxxooxxooxoxxxxxoxxxxxoxoxooxxxxoooooxoxxxoxooxxxoxoooxooo
  ooxoxoxxoxxxoxoxxxoxoooxxxxxxooxoxoxoxoxxoxoooxoxoxxoxxoxxoxxooxxoxxoo
  xoxxxxxoxoxxoooxxoxxoxoxoxxxoooooxoxoxxxxooxoxxooooxoxxxxoxoxxoooxoxoo
  ooxxooxooxooxoxoxxxxxoxooooxoxxxxoxxooxooxoooxooooxooxxooxoxxxooooxxox
  xxxxxxxxoxoxxxxxooooooxoxooooxxxxxxxxoxxooooxxooooxxoooxooxooooxoxxxoo
  xoxoooooooxxoxooxxoxxoxxxxoooxxooxxoxxooooxoxoxoxoxoooxxxoxooxoxoxxxxo
  oxoxxxxxoxxxoooooxxoooxxooxooxoxxoooxxxxxxxxooxoooxoxxoooxxoxxxxoxoxxx

# https://theweeklychallenge.org/blog/perl-weekly-challenge-288/
# https://en.wikipedia.org/wiki/Flood_fill
