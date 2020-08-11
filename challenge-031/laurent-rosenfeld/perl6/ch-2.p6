use v6;

sub MAIN (Str $name, Str $value) {
    my %hash = $name => $value;
    say "The item is called $name and its value is %hash{$name}";
}
