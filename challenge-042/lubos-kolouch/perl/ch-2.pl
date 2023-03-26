use strict;
use warnings;
use List::Util qw(shuffle);
use Test::More tests => 5;

# Generate a random string of brackets
sub generate_bracket_string {
    my $length            = shift;
    my @brackets          = ( '(', ')' );
    my @shuffled_brackets = shuffle(@brackets);
    return join( '', @shuffled_brackets[ 0 .. $length - 1 ] );
}

# Check if a string has balanced brackets
sub is_balanced {
    my $bracket_string = shift;
    my @stack          = ();
    for my $bracket ( split( //, $bracket_string ) ) {
        if ( $bracket eq '(' ) {
            push( @stack, $bracket );
        }
        elsif ( $bracket eq ')' ) {
            if ( @stack == 0 ) {
                return 0;
            }
            pop(@stack);
        }
    }
    return @stack == 0;
}

# Test the is_balanced function
ok( is_balanced(''),     'Empty string is balanced' );
ok( is_balanced('()'),   'Simple brackets are balanced' );
ok( is_balanced('(())'), 'Nested brackets are balanced' );
ok( !is_balanced('(('),  'Unbalanced brackets are not balanced' );
ok( !is_balanced('())'), 'Unbalanced brackets are not balanced' );

# Generate a random string of brackets and check if it has balanced brackets
my $bracket_string = generate_bracket_string(10);
print "Bracket string: $bracket_string\n";
if ( is_balanced($bracket_string) ) {
    print "The bracket string is balanced\n";
}
else {
    print "The bracket string is not balanced\n";
}
