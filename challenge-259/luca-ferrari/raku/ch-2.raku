#!raku

#
# Perl Weekly Challenge 259
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-259>
#


# {%  id   field1="value1"    field2="value2"  field3=42 %}

# Where

# a) "id" can be \w+.
# b) There can be 0  or more field-value pairs.
# c) The name of the fields are \w+.
# b) The values are either number in which case we don't need parentheses or string in
#    which case we need parentheses around them.


sub MAIN() {

    my %parsed;

    my $line = '{%  youtube video=foobar password=xyz abc=def donald="duck here \"escaped\" " %}';

    my regex id { \w+ };
    my regex option {  $<name>= [ \w+ ] \s* <[=]> $<value>= [ \w+ | \" \w+ \s* .* \" ] };
    my regex opening { <[{]> <[%]> };
    my regex closing { <[%]> <[}]> };

    if ( $line ~~ / ^ <opening> \s+ <id> \s+ <option>* % \s  \s* <closing> $ / ) {

	%parsed<name> = $/<id>;

	say $/<option>;
	for $/<option> {
	    my ( $key, $value ) = .split( '=' );
	    %parsed<fields>{ $key } = $value;
	}
    }

    say %parsed;
}
