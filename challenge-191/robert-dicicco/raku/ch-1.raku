use v6;

=begin comment

AUTHOR: Robert DiCicco

DATE: 2022-11-14

Challenge 191 Twice Largest ( Raku )



You are given list of integers, @list.

Write a script to find out whether the largest item in the

list is at least twice as large as each of the other items.

=end comment



my @arr = ([1,2,3,4],[1,2,0,5],[2,6,3,1],[4,5,2,3]);



for (@arr) -> @lst {

  my $result = "good";

  print("Input: @list = (" ~ @lst ~ ")\n");

  my $max = @lst.max;

  my @sorted = @lst.sort;

  my $x = 0;

  while ($x < @lst.elems - 1) {

    if ( (2 * (@sorted[$x]) > $max)) {

      say "Output: -1\n";

      $result = "bad";

      last;

    }

    $x++;

  }

  if ($result eq "good") { say "Output: 1\n"}

}



=begin comment

SAMPLE OUTPUT

Input: @list = (1 2 3 4)

Output: -1



Input: @list = (1 2 0 5)

Output: 1



Input: @list = (2 6 3 1)

Output: 1



Input: @list = (4 5 2 3)

Output: -1

=end comment
