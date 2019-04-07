#!/usr/bin/env perl6 
# The simplest solution I could think of was conversion of a numeric (integer) string through 
# the use of the built-in Int method. Provide a commandline argument like "004", and the script
# will output: 4.
#
# In a Perl6/Bash one-liner, this would look something like this:
#   perl6 -pe '$_=.Int' <<< "004"
# but this, in itself, isn't very practical since Bash can do it with even less fuzz:
#   a="004"
#   echo ${a##+(0)}

sub MAIN (Str $numeric_string) {

    say $numeric_string.Int;
}

