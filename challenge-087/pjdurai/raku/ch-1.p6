use Test;

# Problem: find the longest consecutive sequence. Print 0 if none sequence found.
# Solution:
# Split the input array into sub arrays of consecutive numbers
# Sort by sub array size. Descending.
# Find the largest subarray and return it. Return 0 otherwise.
#    e.g. for input (20, 19, 9, 11, 10)  we compute  [[9 10 11] [19 20]]

sub solve(@N){

    return 0 unless @N.elems;

    my @result = (reduce sub (@acc, $n){
        if !@acc.elems {
                @acc = [[$n],];
            } elsif @acc[*-1][*-1] == $n-1 {
                @acc[*-1].push($n);
            } else {
                @acc.push([$n]);
            }
        @acc;
    }, [], | @N.sort ).sort: { -.elems };

    # find the largest subarray and return. If none, return 0
    return @result[0] if @result[0].elems > 1;
    0;
}

sub MAIN(){
    ok solve((100, 4, 50, 3, 2)) == [2,3,4], "(100, 4, 50, 3, 2)   =>  [2,3,4]";
    ok solve((20, 30, 10, 40, 50)) == 0, "(20, 30, 10, 40, 50)   => 0";
    ok solve((20, 19, 9, 11, 10))== [9, 10, 11], "(20, 19, 9, 11, 10)  => [9,10,11]";
    ok solve(())== 0, "() => 0";
}
