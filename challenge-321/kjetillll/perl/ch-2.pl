
sub fixstr {  my $str = shift; 1 while $str =~ s/[^#]?#//; $str }
sub eqstr { fixstr( $_[0] ) eq fixstr( $_[1] ) }

print   eqstr("ab#c",   "ad#c") ? "🥇" : "💩";
print   eqstr("ab##",   "a#b#") ? "🥇" : "💩";
print ! eqstr("a#b",    "c")    ? "🥇" : "💩";
print   eqstr("##a##c", "c")    ? "🥇" : "💩";
