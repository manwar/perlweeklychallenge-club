use v6;

my $string = "Perl Weekly Challenge";

my $prevIndex = $string.index: 'e';
my $counter = 0;
while $prevIndex {
    $counter++;
    $prevIndex = $string.index: 'e', $prevIndex + 1;
}

$string = $string.subst(/e/, "E", :g);

say "There are $counter 'e' in $string";