sub f { "@{[ map @$_, @_ ]}" =~ s/ //gr =~ /^(.*)\1$/ }
print pop(@$_) ^ f(@$_) ? "ERROR\n" : "ok\n" for
[ ["a", "bc"],           ["ab", "c"]     => 1 ],
[ ["a", "b", "c"],       ["a", "bc"]     => 1 ],
[ ["a", "bc"],           ["a", "c", "b"] => 0 ],
[ ["ab", "c", ""],       ["", "a", "bc"] => 1 ],
[ ["p", "e", "r", "l"],  ["perl"]        => 1 ],

# https://theweeklychallenge.org/blog/perl-weekly-challenge-373
