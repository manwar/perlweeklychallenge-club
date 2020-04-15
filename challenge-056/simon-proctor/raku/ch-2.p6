#!/usr/bin/env raku

use v6;

# BTree as string nodevalue[child1,child2]
# Example tree 5(4(11(7)(2)))(8(13)(9(1)))

grammar BTreeGrammar {
    token TOP { <tree> };
    token tree { <value> ["(" $<left>=<tree> ")"]? ["(" $<right>=<tree> ")"]? };
    regex value { <-[()]>+ }
}

role BTree[::T] {
    has T $.value is required;
    has BTree[T] $.left;
    has BTree[T] $.right;
    
    method Str( ) {
        $!value ~ ( $!left ?? "({$!left.Str()})" !! "" ) ~ ( $!right ?? "({$!right.Str()})" !! "" );
    }

    method gist() {
        self.Str();        
    }

    method traverse() {
        gather {
            if $!left {
                for $!left.traverse -> @t {
                    take ($!value, |@t);
                }
            }
            if $!right {
                for $!right.traverse -> @t {
                    take ($!value, |@t);
                }
            }
            if ! $!left && ! $!right {
                take ( $!value, );
            }
        }
    }

    multi method from-Str('') { }
    
    multi method from-Str( ::?CLASS:U: Str $in ) {
        my $match = BTreeGrammar.parse( $in );
        if ( $match ) {
            self.new(
                value => $match<tree><value>.Str,
                left => self.from-Str( $match<tree><left> ?? $match<tree><left>.Str !! '' ),
                right => self.from-Str( $match<tree><right> ?? $match<tree><right>.Str !! '' )
            );
        } else {
            die "Unable to Parse $in";
        }
            
    }
}

class UBTree does BTree[UInt] {
    submethod BUILD ( :$value, :$left = UBTree, :$right = UBTree ) {
        $!value = $value.UInt();
        $!left = $left;
        $!right = $right;
    }
}

#| Display the example Tree in Str and gist representations
#| also displays all traversals
multi sub MAIN ( 'example' ) {
    my $example = example-tree;
    say $example;
    UBTree.from-Str( $example.Str ).say;
    
    for $example.traverse -> @row {
        @row.join("->").say
    }
}

#| Traverses the example tree and prints any routes that add up to the target.
multi sub MAIN ( UInt $target, 'example' ) {
    my $example = example-tree;

    for $example.traverse -> @row {
        @row.join("->").say if ( [+] @row ) == $target;
    }
}

#| Given a target number and a tree string find all the traversals that add up to is
#| Note the Tree string is in the format "number (left tree) (right tree)" spaces are optional
multi sub MAIN ( UInt $target, *@rest ) {
    my $tree = UBTree.from-Str( @rest.join("") );

    for $tree.traverse -> @row {
        @row.join("->").say if ( [+] @row ) == $target;
    }
}


sub example-tree() {
    return UBTree.new(
        value => 5,
        left => UBTree.new(
            value => 4,
            left => UBTree.new(
                value => 11,
                left => UBTree.new(
                    value => 7,
                ),
                right => UBTree.new(
                    value => 2,
                )
            )
        ),
        right => UBTree.new(
            value => 8,
            left => UBTree.new(
                value => 13,
            ),
            right => UBTree.new(
                value => 9,
                right => UBTree.new(
                    value => 1
                )
            )
        )
    );
}
