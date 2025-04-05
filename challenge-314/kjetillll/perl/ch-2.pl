sub f {
  "@_" !~ /\w/ ? 0 :
  "@_" =~ /(\b\w).*(\b\w)(??{ '^' x ($1 le $2) })/ + f(map s/.//r, @_)
}

print $$_[0] == $$_[1] ? "ok\n" : "err $$_[1]\n" for
[ 2, f("swpc", "tyad", "azbe")                              ],
[ 1, f("cba", "daf", "ghi")                                 ],
[ 0, f("a", "b", "c")                                       ],
[ 0, f(        "abcd", "bcde", "cdef", "defg", "efgh")      ],
[ 1, f(        "abcdZ", "bcdeY", "cdefX", "defgW", "efghV") ],
[ 0, f(        "abcdV", "bcdeW", "cdefX", "defgY", "efghZ") ],
[ 0, f(        "aa", "aa", "aa")                            ],
[ 0, f(        "xyz")                                       ],
[ 1, f(        "abcdV", "bcdeW", "cdefX", "defgY", "efahZ") ],
[ 4, f(reverse "abcd",  "bcde",  "cdef",  "defg",  "efgh")  ],
[ 4, f(reverse "abcdZ", "bcdeY", "cdefX", "defgW", "efghV") ],
[ 3, f(reverse "ebcdZ", "dcdeY", "cdefX", "befgW", "afghV") ],
[ 5, f(reverse "abcdV", "bcdeW", "cdefX", "defgY", "efghZ") ]
