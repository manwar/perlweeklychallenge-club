package MatrixParser::Token;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

sub new ( $class, $lexeme, $line, $pos ) {

    my $self = [ $lexeme, $line, $pos ];

    return bless $self, $class;
}

sub lexeme($self) {
    $self->[0];
}

sub line($self) {
    $self->[1];
}

sub pos($self) {
    $self->[2];
}

1;
