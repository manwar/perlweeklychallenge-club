use v6;

#3 Sum

#Given an array @Lof integers. 
#Write a script to find all unique triplets such that a + b + c is same as the given target T. 
#Also make sure a <= b <= c.

my $target = 0;
my  @L = sort(-25,  -7, -3, 2, 4, -10,8, 10);

for 0..@L.end {
    my $a = $_;
    for  $a+1..@L.end {
        my $b = $_;
        for  $b+1..@L.end {     
            my $c = $_;        
            if  (@L[$a] + @L[$b] + @L[$c]) == $target {
                say "@L[$a] + @L[$b] + @L[$c] = $target";
            }
        }
    }
}
