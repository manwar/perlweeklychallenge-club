use v6;

#`{

AUTHOR: Robert DiCicco

DATE  : 2023-01-09

Challenge 199 Good Pairs ( Raku )

}

 

my @lists = ([1,2,3,1,1,3],[1,2,3],[1,1,1,1]);

my $finalCnt = 0;

 

for (@lists) -> @list {

                print "Input: \@list = [",@list,"]\n";

                my $begin = 0;

                my $ender = @list.elems - 1;

                my $cnt = $begin + 1;

                while ($begin < $ender) {

                                while ( $cnt <= $ender ) {

                                                if (@list[$cnt] == @list[$begin]) {

                                                                print("($begin,$cnt)\n");

                                                                $finalCnt++;

                                                }

                                $cnt++;

                                }

                                $begin++;

                                $cnt = $begin + 1;

                }

                print "Output: $finalCnt\n\n";

                $finalCnt = 0;

}

 

#`{

SAMPLE OUTPUT

raku .\GoodPairs.rk

Input: @list = [1 2 3 1 1 3]

(0,3)

(0,4)

(2,5)

(3,4)

Output: 4

 

Input: @list = [1 2 3]

Output: 0

 

Input: @list = [1 1 1 1]

(0,1)

(0,2)

(0,3)

(1,2)

(1,3)

(2,3)

Output: 6

}
