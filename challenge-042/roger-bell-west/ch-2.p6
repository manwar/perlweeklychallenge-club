#! /usr/bin/perl6

my $s='';
my @c=('(',')');
for (-1 .. 2*(floor(rand*4))) {
  $s ~= @c[floor(rand*2)];
}

print "$s\n";

while ($s ~~ s:g/\(\)//) {
}

if ($s) {
  say "Invalid: $s";
} else {
  say "Valid.";
}
