package MatrixParser;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(none);

use MatrixParser::Lexer;

sub new ( $class, $input ) {
    my $self = {
        lexer         => MatrixParser::Lexer->new($input),
        corners       => [],
        row           => 0,
        col           => 0,
        element_count => undef,
    };

    $self->{lookahead} = $self->{lexer}->next_token;

    return bless $self, $class;
}

# returns an array of hashes with the corner positions (1s) from the input
# matrix. each hash contains the corner positions for the corresponding row in
# the input matrix
sub corners($self) {
    while ( $self->{lookahead} ) {
        $self->_parse_row;
    }
    return $self->{corners};
}

sub _parse_row($self) {
    my $start = $self->_expect('[');

    my $count = 0;
    while ( !$self->_match(']') ) {
        $self->_parse_element;
        $count++;
    }

    $self->_expect(']');
    if ( defined $self->{element_count} && $self->{element_count} != $count ) {
        $self->_unexpected_element_count( $start, $count );
    }
    $self->{element_count} = $count;
    $self->{col}           = 0;
    $self->{row}++;

    return;
}

sub _parse_element($self) {
    if ( $self->_match('1') ) {
        $self->{corners}[ $self->{row} ]{ $self->{col} } = 1;
    }
    elsif ( !$self->_match('0') ) {
        $self->_unexpected_token( $self->{lookahead}, '1|0' );
    }

    $self->{col}++;
    return $self->_next_token()->lexeme;
}

sub _match ( $self, $expect ) {
    $self->_unexpected_eof()
      if !$self->{lookahead};
    return $self->{lookahead}->lexeme eq $expect;
}

sub _expect ( $self, $expect ) {
    my $token = $self->_next_token();
    return $token if $token->lexeme eq $expect;

    $self->_unexpected_token( $token, $expect );
}

sub _next_token($self) {
    my $token = $self->{lookahead};
    $self->{lookahead} = $self->{lexer}->next_token;
    return $token;
}

sub _unexpected_token ( $self, $got, $expect ) {
    die sprintf(
"unexpected character in line %d at position %d. Got '%s', expect: '%s'\n",
        $got->line, $got->pos, $got->lexeme, $expect );
}

sub _unexpected_element_count ( $self, $start, $count ) {
    die sprintf(
"unexpected element count in row %d starting at line %d at position %d. Got %d, expect: %d \n",
        $self->{row} + 1,
        $start->line, $start->pos, $count, $self->{element_count}
    );

}

sub _unexpected_eof ( $self ) {
    die sprintf(
        "unexpected end of input at line %d at position %d.\n",
        $self->{lexer}{line},
        $self->{lexer}{pos}
    );
}

1;
