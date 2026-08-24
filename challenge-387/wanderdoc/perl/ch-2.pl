#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a chemical formula with elements, numbers, and parentheses.

Write a script to count the total number of each type of atom by expanding all grouped multipliers. Then, format and return the final inventory as a single string sorted alphabetically by element name, including the total count only if it is greater than 1.
Example 1

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

Example 2

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

Example 3

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

Example 4

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

Example 5

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
=cut








use Marpa::R2;
use Test2::V0 -no_srand => 1;




my $dsl = <<'END_OF_DSL';
lexeme default = latm => 1
:start         ::= formula
formula        ::= token_group+              action => do_formula
token_group    ::= element count             action => do_element
               | group count                 action => do_group
element        ::= element_token             action => do_element_name
group          ::= '(' formula ')'           action => do_parenthesized_group
count          ::= multiplier                action => ::first
count          ::=                           action => do_empty_count

element_token ~ [A-Z][a-z] | [A-Z]
multiplier ~ [0-9]+

# Whitespace is discarded
:discard ~ whitespace
whitespace ~ [\s]+

END_OF_DSL

sub do_formula
{
     my (undef, @items) = @_;
     my %total;
     for my $item (@items)
     {
          while (my ($element, $count) = each %{$item})
          {
               $total{$element} += $count;
          }
     }
     return \%total;
}

sub do_element_name
{
     my ( undef, $symbol ) = @_; 
     return $symbol; 
}

sub do_element
{
     my (undef, $element, $count) = @_;
     return { $element => $count };
}


sub do_parenthesized_group
{
     my (undef, $open, $formula, $close) = @_;
     return $formula;
}


sub do_group
{
     my (undef, $sub_formula, $multiplier) = @_;
     my %result;
     while (my ($element, $count) = each %{$sub_formula})
     {
          $result{$element} = $count * $multiplier;
     }
     return \%result;
}

sub do_empty_count
{
     return 1;
}

my $grammar = Marpa::R2::Scanless::G->new({ source => \$dsl });


sub parse_formula
{
     my $input = $_[0];
     my $value_ref = $grammar->parse(\$input, 'main' );
     my $output = join("",  
                    map { $_ . (${$value_ref}->{$_} == 1 ? '' : 
                         ${$value_ref}->{$_}) } 
                    sort {$a cmp $b} keys  %{${$value_ref}});
     return $output;
}

is(parse_formula("((N2O)3(H2O)2)2"), "H8N12O10", "Example 1");
is(parse_formula("Mg3(PO4)2"), "Mg3O8P2", "Example 2");
is(parse_formula("(((H)2)3)4"), "H24", "Example 3");
is(parse_formula("NaCl3(O2(S10)2)2Mg"), "Cl3MgNaO4S40", "Example 4");
is(parse_formula("Z2Y3(X2W)2"), "W2X4Y3Z2", "Example 5");
done_testing();
