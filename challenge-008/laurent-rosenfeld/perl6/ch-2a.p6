use v6;
sub center (@str) {
    my $max-size = @str.map({.chars}).max;
    @str.map({" " x (($max-size - .chars) / 2).Int ~ $_})
}

my @strings = "This", "is", "a test of the", "center function";
.say for center @strings;
