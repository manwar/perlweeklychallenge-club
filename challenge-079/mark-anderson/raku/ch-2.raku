=begin usage

Usage: raku ch-2.raku 9 3 1 1 4 2 3 2 5 1 5 8 5 5 4 3 1 7 8 9 9 1 9 5 2 2 6 5 

Output:

9 #                                     # #   #          
8 #                     #             # # #   #          
7 #                     #           # # # #   #          
6 #                     #           # # # #   #       #  
5 #               #   # # # #       # # # #   # #     # #
4 #       #       #   # # # # #     # # # #   # #     # #
3 # #     #   #   #   # # # # # #   # # # #   # #     # #
2 # #     # # # # #   # # # # # #   # # # #   # # # # # #
1 # # # # # # # # # # # # # # # # # # # # # # # # # # # #

111

=end usage

#| MAIN only takes arguments from 1 to 9
unit sub MAIN(*@ints where (.elems > 0 and .all ~~ 1..9));

my $pos = 0;
my $sum = 0;

for @ints.max...1 -> $n {
    say "$n @ints.map({ $_ >= $n ?? "#" !! " " })";
}

while @ints.join ~~ m:c($pos)/ (\d)(\d+)(\d) <?{ $0 > $1.comb.all < $2 }> / {
    $sum += (($0, $2).min <<->> $1.comb).sum;    

    $pos = $/.to - 1;    
}

say "\n", $sum;
