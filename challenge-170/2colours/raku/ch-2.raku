#!/usr/bin/env raku

sub prompt-matrix($name) {
  my $starting-prompt = "$name = ";
  my $indent-prompt = ' ' x $starting-prompt.chars;
  my @prompts = lazy flat $starting-prompt, $indent-prompt xx *;
  gather for @prompts -> $prompt {
    given prompt($prompt).comb(/ '-'? \d+ /)>>.Int {
      last if .elems == 0;
      .take;
    }
  } andthen .List;
}

sub infix:«~>»(@a, @b) {
  |@a, |@b
}

sub infix:<⊗>($a, $b) {
  my @by-matrix = @$a XX<<*<<  $b;
  [~>] @by-matrix.map({ [Z~>] $_ })
}

sub infix:«<_»($output, $size) {
  sprintf('%*s', $size, $output)
}

sub show-matrix($caption, $lines) {
  my $starting-prefix = "$caption = ";
  my $indent = ' ' x $starting-prefix.chars;
  my @prefixes = lazy flat $starting-prefix, $indent xx *;
  my @cols = [Zmax] $lines>>.chars;
  dd @cols;
  $lines >><_>> (@cols,) andthen
    .map: { "[ {.join: ' '} ]" } andthen
    @prefixes <<~<< $_ andthen
    .join: "\n" andthen
    .say;
}

my $a = prompt-matrix('A');
my $b = prompt-matrix('B');
show-matrix 'A ⊗ B', $a ⊗ $b;