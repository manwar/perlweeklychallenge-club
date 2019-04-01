perl -wE "for (1 .. 20) { $p = 0; $q = 0; if (!($_ % 3)) { print
'fizz'; ++$p } if (!($_ % 5)) { say 'buzz'; ++$q; } say '' if $p && !$q;
say $_ if !$p && !$q; }"

#syntax error at -e line 1, near "{  ="
#Unknown regexp modifier "/h" at -e line 1, at end of line
#syntax error at -e line 2, near "++ }"
#Unknown regexp modifier "/h" at -e line 2, at end of line
#syntax error at -e line 2, near "++;"
#syntax error at -e line 2, near "if  &&"
#Unknown regexp modifier "/h" at -e line 3, at end of line
#syntax error at -e line 3, near "! &&"
#Execution of -e aborted due to compilation errors.
