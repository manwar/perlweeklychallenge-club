sub f {
    local $_ = pop;
    1 while s{
               (.?)
               \?
               (.?)
             }
             {
               $1
               .
               ( grep /[^$1$2 ]/, 'a' .. 'z' )[0]
               .
               $2
             }ex;
    $_;
}


print f("a?z")     eq "abz"      ? "ok" : "err", "\n";
print f("pe?k")    eq "peak"     ? "ok" : "err", "\n";
print f("gra?te")  eq "grabte"   ? "ok" : "err", "\n";
print f("a?????b") eq "ababacb"  ? "ok" : "err", "\n";
print f("?a?")     eq "bab"      ? "ok" : "err", "\n";
print f("?")       eq "a"        ? "ok" : "err", "\n";

__END__

For speedup, should it be needed, on very long inputs with many '?' chars
and/or very many inputs, initialize once an @array or a %hash and replace
this construct:

( grep /[^$1$2 ]/, 'a' .. 'z' )[0]

with either this:

$array[ ord($1||'a') ][ ord($2||'a') ]

or this:

$array[ ord($1||'a') * 128 + ord($2||'a') ]

or this if you prefer hashes and accept a little slower lookup than arrays:

$hash{ $1 || 'a', $2 || 'a' }

where the array/hash contains a possible pre-calculated letter for all
26*26=676 possible combinations of the two a-z chars before and after the '?'
and default to 'a' if the '?' are at the beginning or end of the string.

