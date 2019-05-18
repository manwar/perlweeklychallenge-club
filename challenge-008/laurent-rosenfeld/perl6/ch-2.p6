use v6;

sub center (@str) {
    my $max-size = max map { .chars }, @str;
    return map { " " x (($max-size - .chars) / 2).Int ~ $_}, @str;
}

my @strings = "This", "is", "a test of the", "center function";
.say for center @strings;
