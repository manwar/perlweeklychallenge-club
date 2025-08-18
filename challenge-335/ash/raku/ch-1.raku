# Task 1 of the Weekly Challenge 335
# https://theweeklychallenge.org/blog/perl-weekly-challenge-335/#TASK1

say find-common('bella', 'label', 'roller'); # Bag(e l(2))
say find-common('cool', 'lock', 'cook');     # Bag(c o)
say find-common('hello', 'world', 'pole');   # Bag(l o)
say find-common('abc', 'def', 'ghi');        # Bag()
say find-common('aab', 'aac', 'aaa');        # Bag(a(2))

sub find-common(*@words) {
    [∩] @words.map: *.comb.Bag
}
