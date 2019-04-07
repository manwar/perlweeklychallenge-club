# bin/to-base35
sub to_int($_) { my @i = split(/"."/, $_[0]); @i[0] };
my @ARGV = do { sub eval { chomp &EVAL(@_) }; eval( ("0" and q|@*ARGS| or q|@ARGV|) ) };
my ($result, $dict, $base10) = ("", {}, @ARGV[0]);
$dict{$_} = $_ for "1".."9";
$dict{ord($_) - 55} = $_ for "A".."Y";
while ($base10 > 0) {
        $result = join("", $dict{to_int($base10 % 35)}, $result);
            $base10 = to_int($base10 / 35);
}
print("$result\n");
