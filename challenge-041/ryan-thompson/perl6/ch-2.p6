#!/usr/bin/env perl6

# ch-2.p6 - Leonardo numbers
#
# Ryan Thompson <rjt@cpan.org>

use experimental :cached;

# Cached version
sub leo( Int $n ) is cached { $n < 2 ?? 1 !! 1 + leo($n - 1) + leo($n - 2) }

# Manually memoized solution
sub leo_my_memo( Int $n ) {
    state @leo = (1, 1);
    @leo[$n] //= 1 + leo_my_memo($n - 1) + leo_my_memo($n - 2);
}

# Lazily evaluated version
my @leo = 1, 1, 1+*+* ... ∞;

.say for @leo[0..20];
