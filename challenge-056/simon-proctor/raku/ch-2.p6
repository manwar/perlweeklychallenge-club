#!/usr/bin/env raku

use v6;

# BTree as string nodevalue[child1,child2]
# Example tree 5(4(11(7)(2)))(8(13)(9(1)))

grammar BTreeGrammar {
    token TOP { <tree> };
    token tree { <value> ["(" $<left>=<tree> ")"]? ["(" $<right>=<tree> ")"]? };
    regex value { <-[()]>+ }
}

class BTreeRep {...}

role BTree[::T] {
    has T $.value is required;
    has BTree @!nodes[2];
    
    method Str( ) {
        ( $!value , |@.nodes.map( { "({$_})" } ) ).join("");
    }

    method nodes() {
        @!nodes.grep({defined $_});
    }

    method children() {
        @.nodes.elems;
    }
    method gist() {
        BTreeRep.new( tree=>self ).gist();
    }

    method traverse() {
        gather {
            if ( self.children ) {
                for @.nodes -> $n {
                    for $n.traverse -> @t {
                        take ($!value, |@t);
                    }
                }
            } else {
                take ( $!value, );
            }
        }
    }

    multi method from-Str('') { BTree }
    
    multi method from-Str( ::?CLASS:U: Str $in ) {
        my $match = BTreeGrammar.parse( $in );
        if ( $match ) {
            self.new(
                value => $match<tree><value>.Str,
                nodes => [
                          self.from-Str( $match<tree><left> ?? $match<tree><left>.Str !! '' ),
                          self.from-Str( $match<tree><right> ?? $match<tree><right>.Str !! '' )
                      ]
            );
        } else {
            die "Unable to Parse $in";
        }
            
    }
}

class UBTree does BTree[UInt] {
    submethod BUILD ( UInt() :$value, :@nodes ) {
        $!value = $value;
        @!nodes = @nodes;
    }
}

class BTreeRep {
    has @.data;
    has UInt $.join-point;

    multi submethod BUILD ( BTree :$tree where { ! $tree.children } ) {
            @!data = [$tree.value.Str];
            $!join-point = $tree.value.Str.codes div 2;
    }

    multi submethod BUILD ( BTree :$tree ) {
        my ( $left, $right, $left-width, $right-width );
        my ( @ldata, @rdata, $left-pad, $right-pad );

        my $mid-string = '┘';
        $left = BTreeRep.new( tree => $tree.nodes[0] );
        $left-width = $left.data[0].codes;
        @ldata = $left.data;
        @ldata.unshift( (" " x $left.join-point) ~ "┌" ~ ("─" x ($left-width - 1 - $left.join-point) ) );

        if ( $tree.children == 2 ) {
            my $right = BTreeRep.new( tree => $tree.nodes[1] );
            $mid-string = '┴';
            @rdata = $right.data;
            $right-width = @rdata[0].codes;
            @rdata.unshift( ( "─" x ( $right.join-point ) ~ '┐' ~ ( " " x $right-width - 1 - $right.join-point ) ) );
        } else {
            $right-width = 1;
            @rdata = @ldata.map( { " " } );
        }

        if ( $left-width + $right-width + 1 < $tree.value.codes ) {
            $left-pad = 0;
            $right-pad = 0;
            my $extra = $tree.value.codes - ($left-width + $right-width + 1);
            @ldata = @ldata.map( { ( " " x ( $extra div 2 ) ) ~ $_ } );
            @rdata = @rdata.map( { $_ ~ ( " " x ( $extra div 2 + $extra % 2 ) ) } );
        } else {
            $left-pad = $left-width - ($tree.value.codes div 2);
            $right-pad = ($left-width + $right-width + 1) - $left-pad - $tree.value.codes;
        }
        my $top = ( " " x $left-pad ) ~ $tree.value ~ ( " " x $right-pad );
        my $left-fill = gather { for @ldata.elems^..@rdata.elems { take " " x $left-width } };
        my $right-fill = gather { for @rdata.elems^..@ldata.elems { take " " x $right-width } };

        @!data = $top, |( ( (|@ldata, |$left-fill) Z, (|@rdata, |$right-fill) ).map( { state $i=0;$_.join($i++??" "!!$mid-string) } ) );
        $!join-point = $left-pad + ( $tree.value.Str.codes div 2);
    }

    method gist {
        @.data.join("\n");
    }

}

#| Displays a set of Tree Representations
multi sub MAIN( 'rep' ) {
    say BTreeRep.new( tree => UBTree.from-Str( '123(234)(345)' ) );
    say BTreeRep.new( tree => UBTree.from-Str( '1(2)' ) );
    say BTreeRep.new( tree => UBTree.from-Str( '1(2(3))' ) );
    say BTreeRep.new( tree => UBTree.from-Str( '1(2(3(4)(5)))' ) );
    say BTreeRep.new( tree => UBTree.from-Str( '123(234(345)(456))(345(456)(567))' ) );
    say BTreeRep.new( tree => UBTree.from-Str( '12345(2)(3)' ) );
    say BTreeRep.new( tree => UBTree.from-Str( '1234(25678789)(333434354)' ) );
    say BTreeRep.new( tree => UBTree.from-Str( '5(4(11(7)(2)))(8(13)(9(1)))' ) );
}

#| Display the example Tree in Str and gist representations
#| also displays all traversals
multi sub MAIN ( 'example' ) {
    my $example = example-tree;
    say "String : $example";
    UBTree.from-Str( $example.Str ).say;
    
    for $example.traverse -> @row {
        @row.join("->").say
    }
}

#| Traverses the example tree and prints any routes that add up to the target.
multi sub MAIN ( UInt $target, 'example' ) {
    MAIN( $target, example-tree.Str );
}

#| Given a target number and a tree string find all the traversals that add up to is
#| Note the Tree string is in the format "number (left tree) (right tree)" spaces are optional
multi sub MAIN ( UInt $target, *@rest ) {
    my $tree = UBTree.from-Str( @rest.join("") );
    say "Tree :\n{$tree.gist}\n";

    for $tree.traverse -> @row {
        @row.join("->").say if ( [+] @row ) == $target;
    }
}


sub example-tree() {
    return UBTree.new(
        value => 5,
        nodes => [
                  UBTree.new(
                      value => 4,
                      nodes => [
                                UBTree.new(
                                    value => 11,
                                    nodes => [
                                              UBTree.new(
                                                  value => 7,
                                              ),
                                              UBTree.new(
                                                  value => 2,
                                              )
                                          ]
                                )
                            ]
                  ),
                  UBTree.new(
                      value => 8,
                      nodes => [
                                UBTree.new(
                                    value => 13,
                                ),
                                UBTree.new(
                                    value => 9,
                                    nodes => [
                                              UBTree.new(
                                                  value => 1
                                              )
                                          ]
                                )
                            ]
                  )
              ]
    );
}
