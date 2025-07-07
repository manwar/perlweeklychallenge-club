# Task 2 of The Weekly Challenge 329
# https://theweeklychallenge.org/blog/perl-weekly-challenge-329/#TASK2

say longest-substring('YaaAh'); # aaA
say longest-substring('cC');    # cC
say longest-substring('A');     # <None>

# Some additional tests:
say longest-substring('xuWwcC');    # WwcC
say longest-substring('YaaAhbbBB'); # bbBB
say longest-substring('YaaAhbBB');  # aaA being the first one, but bBB also matches

sub longest-substring($str) {
    my @nice;

    for 0 ..^ $str.chars -> $start {
        for $start + 1 .. $str.chars -> $end {
            my $substr = $str.substr($start, $end - $start);

            push @nice, $substr if is-nice($substr);
        }
    }      

    return '<None>' unless @nice;

    my $max-len = @nice.map(*.chars).max;    

    return (@nice.grep: *.chars == $max-len)[0]; # Only returns a single match

    sub is-nice($str) {
        my $chars = $str.comb.Bag;
        my @lc = $chars.keys.grep: * ~~ /<:Lower>/;
        my @uc = $chars.keys.grep: * ~~ /<:Upper>/;
        @uc>>.=lc;

        return @lc.Set eqv @uc.Set;
    }
}
