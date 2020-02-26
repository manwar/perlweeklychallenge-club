use v6;

sub check-parens (Str $expr) {
    my @stack;
    my $s = $expr;
    $s ~~ s:g/\s+//; # remove spaces;
    for $s.comb {
        when '(' { push @stack, $_; }
        when ')' {
            say "$expr: NOT OK" and return unless @stack;
            pop @stack;
        }
        default { say $s }
    }
    say "$expr: ", @stack.elems ?? "NOT OK" !! "OK";
}
for "()", "(  )", "(())", "( ( ))", ")(", "())()", 
    "((( ( ()))))",  "()()()()", "(())(())" {
        check-parens($_)
}
