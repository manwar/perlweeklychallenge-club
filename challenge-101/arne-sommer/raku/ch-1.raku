#! /usr/bin/env raku

unit sub MAIN ($A, :v(:$verbose));

#my @A = $A.words.map({ /^(\d+) \.\. (\d+)$/ ?? ($0 .. $1).list !! $_ }).flat;
my @A = $A.split(/<[\s\,]>+/).map({ /^(\d+) \.\. (\d+)$/ ?? ($0 .. $1).list !! $_ }).flat;

say ": Values: { @A.join(", ") }" if $verbose;

my $elems  = @A.elems;
my $length = @A>>.chars.max;

say ": Number of values: $elems (max length: $length)" if $verbose;

if $elems.is-prime
{
  say @A.join(" ");
  exit;
}

my ($rows, $cols);

if $elems.sqrt ~~ Int
{
  $rows = $cols = $elems.sqrt;
}
else
{
  my @divisors = divisors($elems, :not-self, :not-one);
  my %divisors = @divisors.Set;

  say ": Divisors: { @divisors.join(", ") }" if $verbose;

  my @sizes;

  for @divisors -> $current
  {
    my $div = $elems div $current;  # Integer division.
    if %divisors{$div}
    {
      @sizes.push: ($current => $div);
      say ": Candidate: $current x $div" if $verbose;
    }
  }

  my $tightest = @sizes.sort({ abs($^a.key - $^a.value ) <=> abs($^b.key - $^b.value ) }).first;

  ($rows, $cols) = $tightest.key, $tightest.value;
}

say ": Tightest:  $rows x $cols" if $verbose;

my @matrix;

my $row2 = $rows -1;
my $col2 = $cols -1;

my $current_row = $row2;
my $current_col = 0;

my $direction = 'E';

for @A -> $item
{
  @matrix[$current_row][$current_col] = $item;

  say ": Placing item \"$item\" at [$current_row, $current_col]" if $verbose;

  if $direction eq 'E'
  {
    $current_col < $col2 && ! @matrix[$current_row][$current_col +1].defined
      ?? $current_col++
      !! ( $direction = 'N'; $current_row-- );
  }
  elsif $direction eq 'N'
  {
    $current_row > 0 && ! @matrix[$current_row -1][$current_col].defined
      ?? $current_row--
      !! ( $direction = 'W'; $current_col-- );
  }
  elsif $direction eq 'W'
  {
    $current_col > 0 && ! @matrix[$current_row][$current_col -1].defined
      ?? $current_col--
      !! ( $direction = 'S'; $current_row++ );
  }
  elsif $direction eq 'S'
  {
    $current_row < $row2 && ! @matrix[$current_row +1][$current_col].defined
     ?? $current_row++
     !! ( $direction = 'E'; $current_col++ );
  }
}

for @matrix -> @row
{
  say @row.map({ $_.fmt("%{$length}s") }).join(" ");
}

sub divisors ($number, :$not-self, :$not-one)
{
  my @divisors;
  
  for ($not-one ?? 2 !! 1) .. $number/2 -> $candidate
  {
    @divisors.push: $candidate if $number %% $candidate;
  }
  
  @divisors.push: $number unless $not-self;
  
  return @divisors;
}
