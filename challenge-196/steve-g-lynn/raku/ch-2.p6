#!/usr/bin/env perl6


say &range-list((1,3,4,5,7)); #([3,5])
say &range-list((1,2,3,6,7,9)); #([1,3],[6,7])
say &range-list((0,1,2,4,5,6,8,9)); #([0,2],[4,6],[8,9])

sub range-list( @array) {
    my @arry=@array.sort({$^a <=> $^b}).unique; #-- just in case ...
    @arry=@arry.unshift(-Inf).push(-Inf);
    &print-edges( @arry[(1 .. @arry-2).grep({(@arry[$_]-@arry[$_-1]==1) || (@arry[$_+1]-@arry[$_]==1)})] );    
}

sub print-edges( @ranges ) {
    my $return-string = "([@ranges[0],"; 
    for (1 .. @ranges-2) -> $i {
        ( (@ranges[$i] - @ranges[$i-1]) > 1 ) && 
            ($return-string ~= (@ranges[$i-1] ~ "],[" ~ @ranges[$i] ~ ",")); 
    }
    #-- end the string
    $return-string ~= (@ranges[@ranges-1] ~ "])");
    $return-string;   
}
