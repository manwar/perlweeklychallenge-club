use v6;

grammar Parens {
    token TOP { \s* <paren-expr>+ \s* }
    token paren-expr { | \s* <paren-pair> \s*
                       | '(' \s* <paren-expr>+ \s* ')' }
    token paren-pair { [ '(' \s* ')' ]+ }
}

for "()", "(  )", "(())", "( ( ))", ")(", "())()", 
    "((( ( ()))))",  "()()()()", "(())(())" -> $expr {
    say "$expr - ", Parens.parse($expr) ?? "OK" !! "NOT OK";
}
