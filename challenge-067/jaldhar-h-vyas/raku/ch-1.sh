perl6 -e 'my ($m, $n) = @*ARGS; say q{[ }, (1 .. $m).combinations($n).map({ q{[} ~ @_.join(q{,}) ~ q{]} }).join(q{, }), q{ ]};' $@
