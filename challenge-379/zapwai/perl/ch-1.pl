use v5.38;

my $str = "reverse the given string";
say "Input: \$str = $str";
my @s = split '', $str;
my @r = map {$s[$#s - $_]} (0 .. $#s);
say "Output: ", @r;

# say reverse @s; ## Not allowed!
