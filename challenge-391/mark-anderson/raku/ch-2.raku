#!/usr/bin/env raku
use Test;

is arrange-boxes([1,3], [3,5], [6,8], [2,4]),                  4;
is arrange-boxes([4,5], [4,6], [6,7], [2,3], [4,3]),           3;
is arrange-boxes([5,5], [5,5], [5,5]),                         1;
is arrange-boxes([2,100], [3,200], [4,300], [5,50], [5,400]),  4;
is arrange-boxes([10,20], [15,10], [20,30], [12,18], [16,25]), 3;
is arrange-boxes([1,3], [3,5], [6,8], [2,4],
                 [4,5], [4,6], [6,7], [2,3], [4,3],
                 [5,5], [5,5], [5,5],
                 [2,100], [3,200], [4,300], [5,50], [5,400],
                 [10,20], [15,10], [20,30], [12,18], [16,25]), 6;

sub arrange-boxes(+@boxes)
{
    my $result = 0;
    my @pairs = @boxes.unique(with => &[eqv]).classify(*.head)>>.sort>>.List.sort;

    loop 
    {
        my @result = @pairs.shift.value.head;

        for @pairs -> $pair
        {
            my $k = $pair.value.first(*.tail > @result.tail.tail, :k);
            @result.push: $pair.value[$k] with $k
        }

        $result = @result.elems if @result.elems > $result;
        return $result if $result >= @pairs.elems
    }
}
