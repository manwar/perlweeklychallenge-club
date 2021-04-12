#!raku


sub MAIN() {
    my Int $my-variable = 10;
    "%s @ %0xs (%d)".sprintf( $my-variable.^name, $my-variable.WHERE, $my-variable.WHERE ).say;
}
