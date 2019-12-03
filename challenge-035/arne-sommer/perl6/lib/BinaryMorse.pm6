unit module BinaryMorse;

our %morse =
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
  ',' => '--..--'
);

our %remorse = %morse.antipairs;

our %binary-morse;

for %morse.kv -> $char, $value
{
  %binary-morse{$char} = $value.comb.map({ $_ eq '.' ?? '1' !! '111' }).join('0');
}

our %binary-remorse = %binary-morse.antipairs;
