package My::String::Util;

use strict;
use warnings;
use feature qw'signatures';
no warnings qw'experimental::signatures';

use Exporter qw(import);

our @EXPORT_OK = qw(explode implode contains str_map is_palindromic);

# explode : String -> [Char]
sub explode($str) {
    return split( m//, $str );
}

# implode : [Char] -> String
sub implode(@chars) {
    return join( '', @chars );
}

# contains : String -> Char -> Bool
sub contains ( $str, $char ) {
    return $str =~ m/\Q$char\E/;
}

# str_map: (Char -> Char) -> String -> String
sub str_map ( $fn, $str ) {
    return implode( map { $fn->($_) } explode($str) );
}

# is_palindromic: String -> Boolean
sub is_palindromic($s) {
    return $s eq reverse $s;
}

1;
