my $eu-seq = gather {
  take 1;
  for 1..* -> $n { take $eu-seq[$n - 1] * FatRat.new($n, 2 * $n + 1) }
}

my \π := 2 * [+] $eu-seq[^608];

put π.Str.substr: ^($?FILE.IO.s+1);
