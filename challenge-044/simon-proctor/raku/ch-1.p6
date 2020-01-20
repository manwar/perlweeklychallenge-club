#!/usr/bin/env perl6

use v6.d;

multi sub concat( \a, \b ) { a ~ b }
multi sub concat( \a, @b ) { ( a ~ @b[0], @b[1..*] ) }

my %ops-map = (
    '+' => &infix:<+>,
    '-' => &infix:<->,
    ',' => &infix:<,>,
    '~' => &concat,
);

multi sub selections(0, *@) is pure {
    return [];
}

multi sub selections(1,*@ops) is pure {
    return [[@ops[0]],[@ops[1]]];
}

multi sub selections(UInt \c, *@ops) is pure {
    lazy gather {
        my @recur = selections(c-1, @ops);
        for selections(1, @ops) -> @prefix {
            for @recur -> @list {
                take [|@prefix, |@list];
            }
        }
    }
}

multi sub apply-ops( @list where *.elems == 2, @ops ) {
    return @ops[0]( @list[0], @list[1] );
}

multi sub apply-ops( @list, @ops ) {
    return @ops[0](@list[0],apply-ops( @list[1..*], @ops[1..*] ) );
}

sub display( @nums, @ops ) {
    my $result = @nums.map( -> $v { $v ~ (@ops ?? @ops.shift !! '') } ).join("");
}

my @list = "1".."9";

my @inputs = selections(@list.elems-1, ',', '~').map( -> @sel { apply-ops( @list, @sel.map( { %ops-map{$_} } ) ).flat } );

for @inputs -> @test {
    for selections(@test.elems-1, '+', '-') -> @ops {
        my $result = apply-ops( @test, @ops.map( { %ops-map{$_} } ) );
        if ( $result ~~ 100 ) {
            say "{display(@test,@ops)} = $result";
            exit;
        }
    }
}
