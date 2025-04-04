use experimental 'signatures';


sub find_words ($char, @list) {
    grep $list[$_] =~ /$char/, 0 .. $#list
}


print "@{[ find_words($$_{char}, @{ $$_{list} }) ]}"
   eq "@{$$_{output}}"
    ? "ok\n"
    : "ERROR\n"
   for { list => ["the", "weekly", "challenge"], char => "e", output=>[ 0, 1, 2] },
       { list => ["perl", "raku", "python"],     char => "p", output=>[ 0, 2] },
       { list => ["abc", "def", "bbb", "bcd"],   char => "b", output=>[ 0, 2, 3] };
