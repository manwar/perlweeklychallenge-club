
sub f { 0 + grep s/[a-z]-[a-z]/ab/r =~ s/[!.,]$//r =~ /^[a-z]+$/i, split ' ', pop }

print f($$_[0]) == $$_[1] ? "ok\n" : "ERROR\n" for
[ "cat and dog"              => 3 ],
[ "a-b c! d,e"               => 2 ],
[ "hello-world! this is fun" => 4 ],
[ "ab- cd-ef gh- ij!"        => 2 ],
[ "wow! a-b-c nice."         => 2 ],
