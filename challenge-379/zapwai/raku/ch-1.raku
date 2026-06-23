use v6;

my $str = "reverse the given string";
say "Input \$str = $str";
my @s = $str.comb;
print "Output: ";
for 0 .. @s.end -> $x {
    print @s[@s.end - $x];
}
print "\n";

## say $str.flip; ## Not allowed!
