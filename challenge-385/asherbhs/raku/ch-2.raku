sub outermost-parentheses($str) {
	my $depth = 0;
	$str
		.comb
		.grep({
			when '(' { ++$depth > 1 }
			when ')' { $depth-- > 1 }
		})
		.join
}

say outermost-parentheses '()()()';
say outermost-parentheses '(((())))';
say outermost-parentheses '(()())(())';
say outermost-parentheses '()((()))()';
say outermost-parentheses '(()(()))(()())';
