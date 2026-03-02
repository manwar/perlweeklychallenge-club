
sub f {
    my $s = shift;
    $s =~ s/(.)\1// ? f($s) : $s
}
print f($$_[0]) eq $$_[1] ? "ok\n" : "ERROR\n" for
[ "aabbccdd"    => ""       ],
[ "abccba"      => ""       ],
[ "abcdef"      => "abcdef" ],
[ "aabbaeaccdd" => "aea"    ],
[ "mississippi" => "m"      ],
