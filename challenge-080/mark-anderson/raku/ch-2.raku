# with help from https://www.youtube.com/watch?v=h6_lIwZYHQw

unit sub MAIN(*@N where .all ~~ Int);

my @L2R = candies(@N);
my @R2L = candies(@N.reverse);

say (@L2R Z @R2L.reverse).map(*.max).sum;

sub candies(@N) {
    my @candies = 1 xx @N;

    for @N.keys.skip -> $k {
        if @N[$k] > @N[$k-1] {
            @candies[$k] = @candies[$k-1] + 1;
        }
    }

    @candies;
}
