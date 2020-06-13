use v6.*
=comment
    Given an m × n matrix with non-negative integers,
    write a script to find a path from top left to bottom right which minimizes the sum of all numbers along its path.
    You can only move either down or right at any point in time.

class Step {
    has Int $.v is rw;
    has Str $.path is rw;
    method TWEAK() {
        $!path = $!v.Str
    };
    method add(Step $ext) {
        $.v += $ext.v;
        $.path = $ext.path ~ '->' ~ $.path;
        self
    }
    method show {
        say "$.v: $.path";
    }
}

=comment Generate a random matrix, 1-5 x 1-5 with values from 0-50

my @mat;
my ($m, $n) = ((1..5).roll(2));
for ^$m { @mat[$_] = [ (^50).roll($n).flat ] }

say "Matrix is:";
print-matrix-pretty(@mat);
say 'Solution is:';
minpath(@mat);

#| matrix is a non-sparse mxn matrix, minpath finds the minimum path from a generic matrix
sub minpath(@matrix) {
    my ( $cols, $rows ) = (@matrix.elems , @matrix[0].elems) >>->> 1;
    sub steps($down, $right) {
        my Step $s .= new(v => @matrix[$right][$down]);
        return $s if $down == $rows and $right == $cols;
        (
            (steps($down + 1, $right ) if ($down < $rows)) ,
            (steps($down, $right + 1 ) if ($right < $cols))
        ).flat>>.add($s)
    }
    steps(0, 0 ).min({ .v }).show
}

=comment Only to print out the matrix nicer

constant lceil = "\x23A1";
constant rceil = "\x23A4";
constant lfloor = "\x23A3";
constant rfloor = "\x23A6";
constant lmid = "\x23A2";
constant rmid = "\x23A5";

sub print-matrix-pretty(@matrix) {
    my $rows = @matrix.elems - 1;
    my $wid = @matrix>>.max.max.chars;
    for @matrix.kv -> $row, @ln {
        FIRST { print lceil }
        LAST { say rfloor }
        NEXT {
            given $row {
                when $rows { succeed } #do nothing but prevents rceil on a 1-d matrix
                when 0         { print rceil, "\n", $rows == 1 ?? lfloor !! lmid }
                when $rows - 1 { print rmid, "\n" , lfloor }
                default        { print rmid , "\n", lmid }
            }
        }
        for @ln { .fmt(" %{$wid}d ").print }
    }
}