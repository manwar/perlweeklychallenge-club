my Int @a = (1,2,3,10);
my Int @b = (3,4,3,2);

# I saw the challenge and thought 'Z' the zip operator
# Wanted to give it a go

# First created a separate array with the zipped original arrays
# This creates an array of 2 member lists

my List @c = @a Z @b;

# Tried a raku pointy block to unpack the pairs

my Int $total = 0;
for @c -> ($i, $j) {
    $total = $total + ($i * $j);
}
say $total;

# But could also use flat to flatten the lists
# I like the 'reduction metaoperators' so use that
# for the multiplication

$total = 0;
for @c {
    $total = $total + ([*] flat $_);
}
say $total;

# But then if using a loop, could use a map
# Dispense with the @c array step
# Can also use flat as a method on implied topic

say [+] (@a Z @b).map: {([*] .flat)};

# But checking the 'Z' documentation again
# Z can do the map work itself it turns out

say [+] @a Z* @b;
