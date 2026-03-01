sub f {
    my( $str, $width ) = @_;
    my $missing = $width - length($str);
    my($missing_left, $missing_right) = ($missing>>1, $missing>>1);
    $missing_right++ if $missing%2 == 1;
    "*" x $missing_left . $str . "*" x $missing_right
}

my @tests = (
    [ "Hi",    5 => "*Hi**"      ],
    [ "Code", 10 => "***Code***" ],
    [ "Hello", 9 => "**Hello**"  ],
    [ "Perl",  4 => "Perl"       ],
    [ "A",     7 => "***A***"    ],
    [ "",      5 => "*****"      ],
);
print pop(@$_) eq f(@$_) ? "ok\n" : "ERROR\n" for @tests;
