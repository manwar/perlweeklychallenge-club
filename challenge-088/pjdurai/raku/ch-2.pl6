use Test;
# Solution algoritm.
# We peel layers (like a cake) from the top, then right, then bottom and left until nothing is left.
# String them together for solution.

# Solution walk through
# Input:
#    1 2 3
#    4 5 6
#    7 8 9
#
#    After taking the top layer, it becomes
#    4 5 6
#    7 8 9
#
#    Take the right layer off.
#    4 5
#    7 8
#
#    Take the bootom layer off
#
#    4 5
#
#    Take left layer off.
#    5
#
#    Finally tope layer again
#
#    []
#
#    Collect the removed items in a result list

sub solve(@M) {

    my @directions = |<top right bottom left> xx *;

    my $num-rows = @M.elems;
    my $num-cols = @M[0].elems;

    my @result = reduce sub (@acc, $direction){
        given $direction {
            when 'top' {
                @acc.append(@(@M.shift));
            }
            when 'right' {
                my @right-col = do for @M -> $r {
                    $r.pop;
                }
                @acc.append(@right-col);
            }
            when 'bottom' {
                @acc.append(@M.pop.reverse);
            }
            when 'left' {
                my @left-col = do for @M -> $c {
                    $c.shift;
                }
                @acc.append(@left-col.reverse);
            }
        }
        @acc;
    }, [], |@directions[0..^($num-rows + $num-cols -1)];
}

sub MAIN(){
    my @M = [[  1,  2,  3,  4 ],
             [  5,  6,  7,  8 ],
             [  9, 10, 11, 12 ],
             [ 13, 14, 15, 16 ]];
    say "Problem: ", @M;
    say "Solution: ", solve (@M);

    say "";

    my @M1 = [[ 1, 2, 3 ],
             [ 4, 5, 6 ],
             [ 7, 8, 9 ]];

    say "Problem: ", @M1;
    say "Solution: ", solve (@M1);
}

