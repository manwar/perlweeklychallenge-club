#! /usr/bin/perl6

my $l=7;

my $tilecount=(
  'A' => 8,
  'G' => 3,
  'I' => 5,
  'S' => 7,
  'U' => 5,
  'X' => 2,
  'Z' => 5,
  'E' => 9,
  'J' => 3,
  'L' => 3,
  'R' => 3,
  'V' => 3,
  'Y' => 5,
  'F' => 3,
  'D' => 3,
  'P' => 5,
  'W' => 5,
  'B' => 5,
  'N' => 4,
  'T' => 5,
  'O' => 3,
  'H' => 3,
  'M' => 4,
  'C' => 4,
  'K' => 2,
  'Q' => 2,
    ).BagHash;

my %tilevalue=(
  'A' => 1,
  'G' => 1,
  'I' => 1,
  'S' => 1,
  'U' => 1,
  'X' => 1,
  'Z' => 1,
  'E' => 2,
  'J' => 2,
  'L' => 2,
  'R' => 2,
  'V' => 2,
  'Y' => 2,
  'F' => 3,
  'D' => 3,
  'P' => 3,
  'W' => 3,
  'B' => 4,
  'N' => 4,
  'T' => 5,
  'O' => 5,
  'H' => 5,
  'M' => 5,
  'C' => 5,
  'K' => 10,
  'Q' => 10,
    );

my @bag=$tilecount.grab($l);

my %w;
my $fh=open :r,'wordlist';
for $fh.lines {
  if ($_.chars <= $l) {
    %w{$_.uc}=1;
  }
}
close $fh;

my $maxscore=0;
my @maxcandidate;
my %tried;

for @bag.permutations -> $n {
  my @candidate=$n.list;
  while (@candidate) {
    my $candidate=join('',@candidate);
    if (%tried{$candidate}:exists) {
      last;
    }
    %tried{$candidate}=1;
    if (%w{$candidate}:exists) {
      my $score=sum(map {%tilevalue{$_}}, @candidate);
      if ($score > $maxscore) {
        @maxcandidate=();
        $maxscore=$score;
      }
      if ($score == $maxscore) {
        @maxcandidate.push($candidate);
      }
      last;
    }
    @candidate.pop;
  }
}

print join('',sort @bag),"\n";
print "$maxscore: ",join(' ',sort @maxcandidate),"\n";
