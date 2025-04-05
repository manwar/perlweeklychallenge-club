sub f { pop =~ / ^ @{[ pop =~ s,.,$&+,gr ]} $ /x }

#tests:
print pop@$_ == f(@$_) ? "ok\n" : "err\n" for
[ "perl", "perrrl",                  1 ],
[ "raku", "rrakuuuu",                1 ],
[ "python", "perl",                  0 ],
[ "coffeescript", "cofffeescccript", 1 ]
