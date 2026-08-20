#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 387 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Atoms Count

You are given a chemical formula with elements, numbers, and parentheses.

Write a script to count the total number of each type of atom by expanding all grouped multipliers. Then, format and return the final inventory as a single string sorted alphabetically by element name, including the total count only if it is greater than 1.

=head3 Example 1:

Input: $formula = "((N2O)3(H2O)2)2"
Output: "H8N12O10"

Step 1: Expand the innermost parentheses
    (N2O)3 => N = 2*3 = 6, O = 1*3 = 3 => N6O3
    (H2O)2 => H = 2*2 = 4, O = 1*2 = 2 => H4O2

Step 2: Combine inside the outer parentheses
    Formula becomes: (N6O3 H4O2)2
    Sum up identical elements inside: (N6 H4 O5)2

Step 3: Apply the outer multiplier
    N = 6*2 = 12
    H = 4*2 = 8
    O = 5*2 = 10

Step 4: Sort alphabetically and format
    Alphabetical order: H, N, O
    Counts: H: 8, N: 12, O: 10

=head3 Example 2:

Input: $formula = "Mg3(PO4)2"
Output: "Mg3O8P2"

Step 1: Parse ungrouped elements
    Mg3 => Mg = 3

Step 2: Expand parentheses (PO4)2
    P = 1*2 = 2
    O = 4*2 = 8

Step 3: Total up counts
    Mg = 3
    P  = 2
    O  = 8

Step 4: Sort alphabetically and format
    Alphabetical order: Mg, O, P
    Counts: Mg: 3, O: 8, P: 2

=head3 Example 3:

Input: $formula = "(((H)2)3)4"
Output: "H24"

Step 1: Expand innermost level (H)2
    H = 1*2 = 2 => formula becomes ((H2)3)4

Step 2: Expand middle level (H2)3
    H = 2*3 = 6 => formula becomes (H6)4

Step 3: Expand outer level (H6)4
    H = 6*4 = 24

Step 4: Sort alphabetically and format
    Single element: H: 24

=head3 Example 4:

Input: $formula = "NaCl3(O2(S10)2)2Mg"
Output: "Cl3MgNaO4S40"

Step 1: Expand innermost parentheses (S10)2
    S = 10*2 = 20 => inner formula becomes => O2S20

Step 2: Expand outer parentheses (O2S20)2
    O = 2*2  = 4
    S = 20*2 = 40

Step 3: Combine all parts
    Ungrouped start: Na (Na = 1), Cl3 (Cl = 3)
    Expanded middle: O = 4, S = 40
    Ungrouped end: Mg (Mg = 1)

Step 4: Sort alphabetically and format
    Alphabetical order: Cl (3), Mg (1), Na (1), O (4), S (40)
    Omit the number 1 for Mg and Na.

=head3 Example 5:

Input: $formula = "Z2Y3(X2W)2"
Output: "W2X4Y3Z2"

Step 1: Parse ungrouped elements
    Z2 => Z = 2
    Y3 => Y = 3

Step 2: Expand parentheses (X2W)2
    X = 2*2 = 4
    W = 1*2 = 2

Step 3: Total up counts
    W = 2, X = 4, Y = 3, Z = 2

Step 4: Sort alphabetically and format
    Alphabetical order: W (2), X (4), Y (3), Z (2)

=end pod

grammar Formula {
    regex TOP { <term> <term>* }
    regex term { <sequence> | <grouping> }
    regex sequence { <unit> <unit>* }
    regex grouping { '(' <term> <term>* ')' <qty> }
    regex unit { <unit-explicit> | <unit-implicit> }
    regex unit-explicit { <name> <qty> }
    regex unit-implicit { <name> }
    regex name { <[A..Z]><[a..z]>? }
    regex qty { <[1..9]> <[0..9]>* }
}

class FormulaActions {
    method TOP($/) {
        my @terms = $<term>.map({ .made });
        make self.merge-terms(@terms).kv.map(-> $k, $v { $k ~ ($v == 1 ?? "" !! $v) }).sort.join;
    }
    method term($/) { make $<sequence> ?? $<sequence>.made !! $<grouping>.made }
    method sequence($/) {
        my @units = $<unit>.map({ .made });
        my %h = @units.shift;
        %h{ .key } += .value for @units;
        make %h;
    }
    method grouping($/) {
        my @terms = $<term>.map({ .made });
        my %h = self.merge-terms(@terms);
        %h{ $_ } *= $<qty> for %h.keys;
        make %h;
    }
    method unit($/) { make $<unit-explicit> ?? $<unit-explicit>.made !! $<unit-implicit>.made }
    method unit-explicit($/) { make $<name>.made => $<qty>.made }
    method unit-implicit($/) { make $<name>.made => 1 }
    method name($/) { make ~$/ }
    method qty($/) { make +$/ }
    method merge-terms(@terms) {
        my %h = @terms.shift;
        for @terms -> %t {
            for %t.kv -> $k, $v {
                %h{ $k } += $v;
            }
        }
        %h;
    }
}

sub atoms-count(Str:D $formula --> Str) {
    my $result = Formula.parse($formula, :actions(FormulaActions));
    die "Unable to parse formula $formula" unless $result;
    $result.made
}

#| return counts of each type of atom given in FORMULA
multi MAIN(Str:D $formula) {
    say atoms-count($formula);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "((N2O)3(H2O)2)2", output => "H8N12O10"));
    @tests.push(%( input => "Mg3(PO4)2", output => "Mg3O8P2"));
    @tests.push(%( input => "(((H)2)3)4", output => "H24"));
    @tests.push(%( input => "NaCl3(O2(S10)2)2Mg", output => "Cl3MgNaO4S40"));
    @tests.push(%( input => "Z2Y3(X2W)2", output => "W2X4Y3Z2"));
    @tests.push(%( input => "H", output => "H"));
    @tests.push(%( input => "He", output => "He"));
    @tests.push(%( input => "H2", output => "H2"));
    @tests.push(%( input => "He2", output => "He2"));
    @tests.push(%( input => "HH", output => "H2"));
    @tests.push(%( input => "HeHe", output => "He2"));
    @tests.push(%( input => "H2O", output => "H2O"));
    @tests.push(%( input => "H2OH2O", output => "H4O2"));
    @tests.push(%( input => "He2O", output => "He2O"));
    @tests.push(%( input => "He2OHe2O", output => "He4O2"));
    @tests.push(%( input => "H33O44", output => "H33O44"));
    @tests.push(%( input => "He33Zi44", output => "He33Zi44"));
    @tests.push(%( input => "(H)2", output => "H2"));
    @tests.push(%( input => "(H2O)2", output => "H4O2"));
    @tests.push(%( input => "H(H2O)2", output => "H5O2"));


    my @should-throw;
    @should-throw.push(%( input => "" ));
    @should-throw.push(%( input => "Hee" ));      # names are one uppercase letter and zero or one lowercase letter
    @should-throw.push(%( input => "e" ));
    @should-throw.push(%( input => "(H)" ));      # parens require a quantity
    @should-throw.push(%( input => "H0" ));       # quantities cannot start with zero
    @should-throw.push(%( input => "2H" ));
    @should-throw.push(%( input => "(H2" ));
    @should-throw.push(%( input => "H2)" ));

    plan @tests + @should-throw + 3;
    for @tests {
        is atoms-count(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { atoms-count(.<input>) }, Exception, "dies on { .<input> }", message => /'Unable to parse'/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'H2O', :out, :err);
    is $proc.out.slurp(:close).trim, 'H2O', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
