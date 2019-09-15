#! /usr/bin/env perl6

subset ChaoChar of Str where $_ eq any ('A' .. 'Z');
subset ChaoStr  of Str where /^ <[A .. Z]>+ $/;

subset ChaoAlphabet of Str where $_.chars == 26 && $_.comb.sort.join eq 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

unit sub MAIN (ChaoStr      $message,
               Bool         :$verbose,
	       Bool         :$decipher,
	       ChaoAlphabet :$left = ('A' ... 'Z').pick(*).join,
	       ChaoAlphabet :$right  = ('A' ... 'Z').pick(*).join);

my @left = $left.comb; # also called "left"
my @right  = $right.comb;  # also called "right"

say "!! { @left.join }  { @right.join }" if $verbose;

constant ZENITH = 0;    # Shown as '+'
constant NADIR  = 13;   # Shown as '*'
constant END    = 25; 

my $encoded-message = "";

for $message.comb -> $letter
{
  my $encoded-letter = $decipher
    ?? left2right($letter)
    !! right2left($letter);

  $encoded-message ~= $encoded-letter;

  if ($decipher)
  {
    @left  .= rotate while @left[ZENITH]  ne $letter;
    @right .= rotate while @right[ZENITH] ne $encoded-letter;
  }
  else
  {
    @left  .= rotate while @left[ZENITH]  ne $encoded-letter;
    @right .= rotate while @right[ZENITH] ne $letter;
  }
  @right .= rotate;
  
  @left  = @left[ZENITH, ZENITH + 2 .. NADIR, ZENITH + 1, NADIR + 1 .. END].flat;
  @right = @right[ZENITH, ZENITH + 1, ZENITH + 3 .. NADIR, ZENITH + 2, NADIR + 1 .. END].flat;
  
  say "!! { @left.join }  { @right.join }   $encoded-letter   $letter" if $verbose;
}

sub right2left (ChaoChar $letter)
{
  for 0 .. Inf -> $index  # we could have used 'index', if we had a string!!
  {
    return @left[$index] if @right[$index] eq $letter;
  }
}

sub left2right (ChaoChar $letter)
{
  for 0 .. Inf -> $index  # we could have used 'index', if we had a string!!
  {
    return @right[$index] if @left[$index] eq $letter;
  }
}

say $encoded-message;