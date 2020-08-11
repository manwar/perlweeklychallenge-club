#!/usr/bin/env perl6

# ch-1.p6 - Survivor
#
# Ryan Thompson <rjt@cpan.org>

sub MAIN( Int $N = 50 ) {
    my Int @ll = 0, |[1..$N].rotate;
    my Int $cur = 1;

    @ll[$cur] = @ll[ @ll[$cur] ] and $cur = @ll[$cur] until @ll[$cur] == $cur;

    say $cur;
}
