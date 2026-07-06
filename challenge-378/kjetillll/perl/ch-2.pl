sub f {
  ! ( pop =~ y/a-j/0-9/r
    - pop =~ y/a-j/0-9/r
    - pop =~ y/a-j/0-9/r )
}
sub f_alternative1 { my($a, $b, $c) = map y/a-j/0-9/r, @_; $a + $b == $c }
sub f_alternative2 { eval "@_" =~ y/a-j/0-9/r =~ s/ /+/r =~ s/ /==/r =~ s/\b0+\B//gr }

my($true, $false) = (1, 0);
print pop(@$_) ^ f( @$_ ) ? "ERROR\n" : "ok\n" for
[ "acb", "cba", "cdb" => $true  ],
[ "aab", "aac", "ad"  => $true  ],
[ "bc", "je", "jg"    => $false ],
[ "a", "aaaa", "aa"   => $true  ],
[ "c", "d", "h"       => $false ];
