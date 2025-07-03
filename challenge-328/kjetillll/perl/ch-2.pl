use v5.10;

sub f {
    state $regex_list = join '|', map { uc.lc, lc.uc } 'a' .. 'z'; #Aa|aA|Bb|bB ... Zz|zZ
    my $str = shift;
    1 while $str =~ s/$regex_list//g;
    $str
}


print f( "WeEeekly" ) eq "Weekly" ? "ok\n" : "err\n";
print f( "abBAdD" )   eq ""       ? "ok\n" : "err\n";
print f( "abc" )      eq "abc"    ? "ok\n" : "err\n";

#'state' instead of 'my' inits $regex_list only once even though f() is called multiple times.
#It also makes $regex_list invisible outside of sub f. Needs at least 'v5.10' for 'state' to be available.
