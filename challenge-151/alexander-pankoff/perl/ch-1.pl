#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

# TASK #1 › Binary Tree Depth
# Submitted by: Mohammad S Anwar
#
# You are given binary tree.
#
# Write a script to find the minimum depth.
#
#     The minimum depth is the number of nodes from the root to the nearest leaf node (node without any children).
#
# Example 1:
#
# ```
# Input: '1 | 2 3 | 4 5'
#
#                 1
#                / \
#               2   3
#              / \
#             4   5
#
# Output: 2
# ```
#
#
# ```
# Example 2:
#
# Input: '1 | 2 3 | 4 *  * 5 | * 6'
#
#                 1
#                / \
#               2   3
#              /     \
#             4       5
#              \
#               6
# Output: 3
# ```

run() unless caller();

sub run() {
    my ($input) = @ARGV;

    my @tokens = tokenize($input);
    say minimum_binary_tree_depth(@tokens);
}

sub minimum_binary_tree_depth ( @tokens) {
    my $depth = 0;
    my $tree  = [];

    while (@tokens) {
        push @$tree, [];
        my $num_elems = 2**$depth;
        for ( my $i = 0 ; $i < $num_elems ; $i++ ) {

            if ( !@tokens || $tokens[0]->isa('SeparatorToken') ) {
                ## fill row with dummy placeholder tokens.
                unshift @tokens,
                  map { PlaceHolderToken->new(-1) }
                  0 .. ( $num_elems - 1 - $i );    # Dummy Token
            }

            my $cur = shift @tokens;
            if ( $cur->isa('ValueToken') ) {
                if ( $depth && !defined( $tree->[-2][ int( $i / 2 ) ] ) ) {
                    die join( " ",
                        "Missing parent for node with value",
                        $cur->{lexeme},
                        "at position",
                        $cur->pos_human_readable(),
                        "in input\n" );
                }
                push @{ $tree->[-1] }, $cur->{lexeme};
            }
            elsif ( $cur->isa('PlaceHolderToken') ) {
                if (   $i % 2
                    && !defined $tree->[-1][-1]
                    && ( !$depth || defined $tree->[-2][ int( $i / 2 ) ] ) )
                {
                    return $depth;
                }
                push @{ $tree->[-1] }, undef;
                ## do nothing
            }
        }

        $depth += 1;

        # handle optional separatortoken
        if ( @tokens && $tokens[0]->isa("SeparatorToken") ) {
            shift @tokens;
        }
    }

    return $depth;
}

sub tokenize ( $input) {
    my @tokens;
    my $pos = 0;
    while ( $pos < length $input ) {
        my $cur = substr( $input, $pos, 1 );

        if ( $cur =~ m/\|/ ) {
            push @tokens, SeparatorToken->new($pos);
            $pos += 1;
        }
        elsif ( $cur =~ m/\*/ ) {
            push @tokens, PlaceHolderToken->new($pos);
            $pos += 1;
        }
        elsif ( $cur =~ m/\d/ ) {
            my $start_pos = $pos;
            my $lexeme    = '';
            do {
                $lexeme .= $cur;
                $pos += 1;
                $cur = substr( $input, $pos, 1 );
            } while ( $cur =~ m/\d/ );
            push @tokens, ValueToken->new( $lexeme, $pos );
        }
        elsif ( $cur =~ m/\s/ ) {
            do {
                $pos += 1;
                $cur = substr( $input, $pos, 1 );
            } while ( $cur =~ m/\s/ );
        }
        else {
            my $pos_human_readable = $pos + 1;
            die "Unexpected input at position $pos_human_readable: '$cur'\n";
        }
    }
    return @tokens;
}

package TokenType {

    sub new ( $class, $lexeme, $pos ) {
        return bless { lexeme => $lexeme, position => $pos }, $class;
    }

    sub pos_human_readable($self) {
        return $self->{position} + 1;
    }
}

package ValueToken {
    use base 'TokenType';
}

package PlaceHolderToken {
    use base 'TokenType';

    sub new ( $class, $pos ) {
        return bless { lexeme => '*', position => $pos }, $class;
    }
}

package SeparatorToken {
    use base 'TokenType';

    sub new ( $class, $pos ) {
        return bless { lexeme => '|', position => $pos }, $class;
    }
}
