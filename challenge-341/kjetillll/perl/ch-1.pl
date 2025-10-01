sub f { 0 + grep /^[^_@_]+$/i, shift =~ /\w+/g }

print pop(@$_) == f(@$_) ? "ok\n" : "error\n" for
[ 'Hello World',          'd'       => 1 ],
[ 'apple banana cherry',  'a', 'e'  => 0 ],
[ 'Coding is fun',                  => 3 ],
[ 'The Weekly Challenge', 'a', 'b'  => 2 ],
[ 'Perl and Python',      'p'       => 1 ],
