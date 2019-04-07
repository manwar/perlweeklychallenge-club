my @ARGV = do { sub eval { chomp &EVAL(@_) }; eval( ("0" and q|@*ARGS| or q|@ARGV|) ) };
my ($state, $result, $dict, $base35) = (1, "", {}, @ARGV[0]);
$dict{$_} = $_ for "1".."9";
$dict{$_} = ord($_) - 55 for "A".."Y";
for (reverse grep &{ sub ($_) { $_ ne "" } }.(), split("", $base35)) {
        $result += $state * $dict{$_};
            $state *= 35;
};
print("$result\n");
