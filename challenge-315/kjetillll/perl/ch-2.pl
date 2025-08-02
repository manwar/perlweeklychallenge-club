use experimental 'signatures';


sub find_third ($sentence, $first, $second) {
    $sentence =~ / \b $first \s+ ($second \s+ (\w+).*)/sx
              ? ( "$2", find_third($1, $first, $second) )
              : ()
}


print join(',', @f=find_third(@$_{qw(sentence first second)}))
   eq join(',',@{$$_{output}})
    ? "ok\n"
    : "ERROR @f\n"
  for
    {
      sentence => "Perl is a my favourite language but Python is my favourite too.",
      first    => "my",
      second   => "favourite",
      output   => ["language", "too"]
    },
    {
      sentence => "Barbie is a beautiful doll also also a beautiful princess.",
      first    => "a",
      second   => "beautiful",
      output   => ["doll", "princess"]
    },
    {
      sentence => "we will we will rock you rock you.",
      first    => "we",
      second   => "will",
      output   => ["we", "rock"]
    }
