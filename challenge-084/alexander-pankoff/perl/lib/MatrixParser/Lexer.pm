package MatrixParser::Lexer;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(none);

use MatrixParser::Token;

sub new ( $class, $input ) {
    my $self = {
        input => [ split( //, $input ) ],
        line  => 1,
        pos   => 0
    };

    return bless $self, $class;
}

sub next_token($self) {
    $self->_skip_whitespace;
    return if $self->_eof;

    my $char = $self->_advance();

    $self->_unexpected_input($char)
      if none { $_ eq $char } qw(1 0 [ ]);

    return MatrixParser::Token->new( $char, $self->{line}, $self->{pos} );
}

sub _skip_whitespace($self) {
    return if $self->_eof;
    while (1) {
        my $char = $self->_peek;
        last if !defined $char or $char !~ /\s/;

        $self->_advance;
        if ( $char eq "\n" ) {
            $self->{line} += 1;
            $self->{pos} = 0;
        }
    }
}

sub _eof($self) {
    return !( scalar @{ $self->{input} } );

}

sub _peek($self) {
    return $self->{input}[0];
}

sub _advance($self) {
    return if $self->_eof;
    $self->{pos} += 1;
    return shift @{ $self->{input} };
}

sub _unexpected_input ( $self, $char ) {
    die sprintf( "unexpected input '%s' in line %d at position %d\n",
        $char, $self->{line}, $self->{pos} );
}

1;
