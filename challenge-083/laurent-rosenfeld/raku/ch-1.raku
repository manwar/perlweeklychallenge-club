use v6;

my $str = @*ARGS[0] // "The purpose of our lives is to be happy";
my $trimmed = join "", $str.words[1..*-2];
say $trimmed.chars;
