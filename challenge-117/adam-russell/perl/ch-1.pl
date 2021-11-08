use strict;
use warnings;
##
# You are given text file with rows numbered 1-15 in 
# random order but there is a catch one row in missing in the file.
# Write a script to find the missing row number.
##   
sub find_missing{
    my(@numbers) = sort {$a <=> $b} @_;
    for(my $i=0; $i< @numbers - 1; $i++){
        return $numbers[$i] + 1 if $numbers[$i] != $numbers[$i + 1] - 1;   
    }  
}

MAIN:{
    my @line_numbers; 
    while(<DATA>){
        chomp;
        m/([0-9]+),.*/;
        push @line_numbers, $1;
    }
    my $missing = find_missing(@line_numbers);
    print "$missing\n"; 
}

__DATA__
11, Line Eleven
1, Line one
9, Line Nine
13, Line Thirteen
2, Line two
6, Line Six
8, Line Eight
10, Line Ten
7, Line Seven
4, Line Four
14, Line Fourteen
3, Line three
15, Line Fifteen
5, Line Five
