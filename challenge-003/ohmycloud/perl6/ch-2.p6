
sub ugly-number(Int $index) {
    return 0 if $index == 0;
    my @baselist = [1];
    my ($min2, $min3, $min5) = 0,0,0;
    my $curnum = 1;

    while $curnum < $index {
        my $minnum = (@baselist[$min2] * 2,  @baselist[$min3] * 3,  @baselist[$min5] * 5).min; 
        @baselist.append($minnum);

        while @baselist[$min2] * 2 <= $minnum { $min2 += 1 }
        while @baselist[$min3] * 3 <= $minnum { $min3 += 1 }
        while @baselist[$min5] * 5 <= $minnum { $min5 += 1 }

        $curnum +=1
     }

    return @baselist[*-1] 
}

sub MAIN(Int $count) {
    ugly-number($_).say for 1..$count;
}