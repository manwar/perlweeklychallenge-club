use Test;

plan 2;

my $S = "The Weekly Challenge";

ok words-length($S) == 6, "$S == 6";

$S = "The purpose of our lives is to be happy";

ok words-length($S) == 23, "$S == 23";

sub words-length($S) {
    $S.words[1..*-2].join.chars;
}
