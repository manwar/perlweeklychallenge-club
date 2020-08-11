unit module BinaryMorse2;

my %morse =
(
   A  => '.-',
   B  => '-...',
   C  => '-.-.',
   D  => '-..',
   E  => '.',
   F  => '..-.',
   G  => '--.',
   H  => '....',
   I  => '..',
   J  => '.---',
   K  => '-.-',
   L  => '.-..',
   M  => '--',
   N  => '-.',
   O  => '---',
   P  => '.--.',
   Q  => '--.-',
   R  => '.-.',
   S  => '...',
   T  => '-',
   U  => '..-',
   V  => '...-',
   W  => '.--',
   X  => '-..-',
   Y  => '-.--',
   Z  => '--..',
   0  => '-----',
   1  => '.----',
   2  => '..---',
   3  => '...--',
   4  => '....-',
   5  => '.....',
   6  => '-....',
   7  => '--...',
   8  => '---..',
   9  => '----.',
  '.' => '.-.-.',
  ',' => '--..--',
  '?' => '..--..'
);

my %remorse = %morse.antipairs;

my %binary-morse;

for %morse.kv -> $char, $value
{
  %binary-morse{$char} = $value.comb.map({ $_ eq '.' ?? '1' !! '111' }).join('0');
}

my %binary-remorse = %binary-morse.antipairs;

constant unknown = '?';

our sub morsify (Str $text)
{
  my @words;
  
  for $text.split(/\s+/) -> $word
  {
    my @new-word;
    for $word.comb -> $character
    {
      @new-word.push(%binary-morse{$character} // %binary-morse{$character.uc} // %binary-morse{unknown} );
    }
    @words.push(@new-word.join('000'));
  }

  return @words.join("0000000");
}

subset BinaryMorse of Str where * ~~ /^<[01]>*$/;

our sub demorsify (BinaryMorse $text)
{
  my @words;

  for $text.split("0000000") -> $word
  {
    my $new-word = "";
    for $word.split("000") -> $character
    {
      $new-word ~= %binary-remorse{$character} //unknown;
    }
    @words.push($new-word);
  }
  return @words.join(" ");
}

