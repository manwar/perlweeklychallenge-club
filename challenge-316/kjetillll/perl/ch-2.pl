#Makes a regexp out of the first string by putting .* behind each char
#and match that against the second input string.

sub f { pop =~ m|@{[ pop =~ s/./\Q$&\E.*/gr ]}| }

print   f( "uvw", "bcudvew"       ) ? "ok\n" : "error\n";   # true
print ! f( "aec", "abcde"         ) ? "ok\n" : "error\n";   # false
print   f( "sip", "javascript"    ) ? "ok\n" : "error\n";   # true
print ! f( "ae.", "abcdef"        ) ? "ok\n" : "error\n";   # false
print   f( "ae.", "abcde.f"       ) ? "ok\n" : "error\n";   # false
print   f( "ae.x(", "abcdef.kx(+" ) ? "ok\n" : "error\n";   # false

#regexp allergy?
sub f2 {
    my @substr = split//, shift;
    my @str    = split//, shift;
    $_ eq $substr[0] and shift @substr for @str;
    !@substr
}
