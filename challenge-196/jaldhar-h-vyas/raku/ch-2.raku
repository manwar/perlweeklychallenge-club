#!/usr/bin/raku

sub MAIN(
    *@array #= a list of integers
) {
    my @allranges;
    my $n = 0;

    while $n < @array.end {
        my $r = $n;
        my @range = ( @array[$r] );
        until $r == @array.end {
            $r++;
            if @array[$r] - @array[$r - 1] == 1 {
                @range.push(@array[$r]);
            } else {
                last;
            }
        }
        $n = $r;
        @allranges.push(@range);
    }

    @allranges =  @allranges.grep({ @$_.elems > 1 }).map({ "[{@$_[0]},{@$_[*-1]}]"; });
    say @allranges.join(q{, });
}