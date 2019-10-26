# Create a script to demonstrate creating dynamic variable name, assign a value
# to the variable and finally print the variable. The variable name would be
# passed as command line argument.

# Example usage:
#
#   > perl6 ch2.p6 my_var 37
#   $my_var = 37
#

sub MAIN($name, $value) {
    GLOBAL::{'$' ~ $name} = $value;
    say '$' ~ $name ~ " = " ~ GLOBAL::{'$' ~ $name};
}
