#
# With help from https://www.wikihow.com/Solve-a-Magic-Square
#

use Scalar::History;

unit sub MAIN(UInt $n where * mod 2);
#= a positive odd integer

say odd-magic-square($n);

sub odd-magic-square($n) {
    subset Valid of UInt where 0 <= * < $n;

    my $r := Scalar::History.create(0, Valid);
    my $c := Scalar::History.create(($n / 2).floor, Valid); 
    my @matrix = [0 xx $n] xx $n;
    @matrix[$r][$c] = 1; 

    for 2..($n**2) -> $num {
        try $r--; if $! { $r = $n - 1 }
        try $c++; if $! { $c = 0      } 

        if @matrix[$r][$c] {
            $r = $r.VAR.get-history.tail + 1;
            $c = $c.VAR.get-history.tail;
        }
 
        @matrix[$r][$c] = $num;
    }

    @matrix.map(*.fmt("%{($n**2).chars}d").Array);
}
