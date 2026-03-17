sub f {
    my($str, $k) = @_;
    $str =~ s/ [a-z] / ord($&) - 96 /gex;
    $k == 0 ? $str : f( eval(join '+', $str =~ /./g), $k - 1)
}

print pop(@$_) == f(@$_) ? "ok\n" : "ERROR\n" for
[ "abc",                           1 => 6      ],
[ "az",                            2 => 9      ],
[ "cat",                           1 => 6      ],
[ "dog",                           2 => 8      ],
[ "perl",                          3 => 6      ],
[ "asdfasdfasdfasdfasdfxyz" x 999, 1 => 125874 ],
[ "asdfasdfasdfasdfasdfxyz" x 999, 2 => 27     ],
[ "asdfasdfasdfasdfasdfxyz" x 999, 3 => 9      ]

# https://theweeklychallenge.org/blog/perl-weekly-challenge-365/
