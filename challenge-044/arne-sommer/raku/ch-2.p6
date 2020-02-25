#! /usr/bin/env raku

unit sub MAIN (:$verbose, :$infinite);

my $lowest-match = Inf;

my %found;

for ^Inf
{
  my $binary = .base(2);

  print ": $_ -> $binary " if $verbose;

  my $val  = 1;
  my $path = "";
  
  for $binary.comb -> $digit
  {
    $digit == 1
      ?? ( $val += $val; $path ~= "*" )
      !! ( $val += 1;    $path ~= "+" );

    last if %found{$path};

    say " | $path -> $val" if $val >= 200 && $verbose;

    if $val == 200
    {
      %found{$path} = True;
      say "Match: $val at { $path.chars } steps (path: $path).";
      $lowest-match = $path.chars;
      if $verbose
      {
        my $curr = 1;
	my $step = 1;
	say ": Initial value: 1";
        for $path.comb -> $operator
	{
          $operator eq "+" ?? ( $curr += 1 ) !! ( $curr += $curr );
	  say ": Step { $step++ }: $operator -> $curr";
        }
      }
    }
    
    last if $val >= 200;
    
    exit if !$infinite && $path.chars > $lowest-match;
  }
  
  say " | $path -> $val" if  $val < 200 && $verbose;
}
