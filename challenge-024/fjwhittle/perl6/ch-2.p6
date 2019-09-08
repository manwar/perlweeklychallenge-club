unit sub MAIN (*@file);

my %index;

for @file.map(*.?IO).grep({.?f && .?r}) -> $file {
  %index.push:
    $file.comb(/\w+/, :match).hyper.map({ .Str.fc => $($file.path => .pos,) });
}

while my $word = prompt 'Find? ' {
  %index{$word.fc}».say;
}
