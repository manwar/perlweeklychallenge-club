use v6;

my $input = @*ARGS[0] // "    Perl and   Raku are  part of the same family  ";
say $input.words.reverse.join(" ");
