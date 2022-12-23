#!/usr/bin/env raku

#`{

----------------------------------------------

AUTHOR: Robert DiCicco

DATE  : 2022-12-20

Challenge 196 Pattern 132 ( Raku )

SAMPLE OUTPUT

raku .\Pattern132.rk

Input: @n = [3 1 4 2]

Output: 1 4 2

 

Input: @n = [1 2 3 4]

Output: -1

 

Input: @n = [1 3 2 4 6 5]

Output: 1 3 2

 

Input: @n = [1 3 4 2]

Output: 1 3 2

----------------------------------------------

}

 

my @lists = [[3, 1, 4, 2],[1, 2, 3, 4],[1, 3, 2, 4, 6, 5],[1, 3, 4, 2]];

 

my @out = [];

 

sub findFirst(@list) {

  for 0..(@list.elems - 1) -> $fi {

    if @list[$fi] == 1 {

      @out.push: @list[$fi];

      return $fi

    }

  }

}

 

sub findSecond(@list, $fi is copy) {

  $fi++;

  while $fi < @list.elems {

    if @list[$fi] >= 3 {

      @out.push: @list[$fi];

      return $fi;

    }

    $fi++;

  }

  return -1;

}

 

sub findThird(@list, $fi is copy) {

  $fi++;

  while $fi < @list.elems {

    if @list[$fi] ~~ any [1,2,3,4,5,6,7,8,9] {

      if @list[$fi] < @out[1] { (@out.push: @list[$fi])}

    }

    $fi++;

  }

  return -1;

}

 

for @lists -> @list {

  @out = [];

  put "Input: @n = \[" ~ @list ~ "]";

  my $retval = findFirst(@list);

  my $secval = findSecond(@list, $retval);

  my $thirdval = findThird(@list, $secval);

  (@out.elems == 3) ?? put("Output: ",@out,"\n") !! put("Output: -1\n");

}
