#! /opt/local/bin/perl
#
#        encode_binary_morse.pl
#
#        TASK #1
#         Write a program to encode text into binary encoded morse code. Pay
#         attention to any changes which might need to be made to the text to
#         make it valid morse code.
#
#         Morse code consists of dots, dashes and gaps. It can be encoded in
#         binary in the following fashion:
#
#             dot:                     1
#             dash:                    111
#             intra-character gap:     0
#             character gap:           000
#             word gap:                0000000
#             An intra-character gap is inserted between the dots and dashes in a character.
#
#         method: obviously a translation table directly from letters of the
#         alphabet to precalculated BCM strings would miss the point
#        of this effort, so we will set ourselves to task and only allow
#        ourselves to start from scratch, with:
#
#        Recommendation M.1677-1 (10/2009), pub. by International Telecommunications Union.
#
#        Copying that text and massaging it (it's not ascii text of course -- proceed with
#        caution) eventually got me the table that encodes letters into morse
#        sequences. Note once we have this, we can proceed to the creating Binary
#        Coded Morse.
#
#        Binary Coded Morse is better thought of a direct translation of the
#        morse signal, rather than the letters represented by that code. So the
#        message is first encoded into morse, then those dots and dashes
#        translated into BCM. It preserves the time structure of the morse, as
#        laid down in the specification:
#             2.1    A dash is equal to three dots.
#             2.2    The space between the signals forming the same letter is equal to one dot.
#             2.3    The space between two letters is equal to three dots.
#             2.4    The space between two words is equal to seven dots.
#        As you can see, every binary digit represents one beat interval, with a
#        either a signal present (1) or absent (0).
#
#         The standard for International Morse Code consists of 56 signals that
#         correspond to the 26 latin letters, an accented e, the numerals 0-9, a
#         variety of punctuation, and 6 meta signals for operator transmission
#         negotiation and notification of errors. Although that is the extant of
#         the standard put forth by the ITU, many informal signals have arisen,
#         such as the well-known abbreviation 'SOS'. As these are not truly
#         standardized and are more colloquialisms and practical hacks to
#         communication, they will be considered outside the scope of this
#         exercise.
#
#         We have left the meta-signals in the lookup table for completeness,
#         each with a shortened key, and we will end up using a few of them
#         along the way, indirectly. The <Invitation to Talk>, used at the end
#         of a transmission signal, stating "I'm done transmitting this message,
#         now you may respond" is the reused letter 'K' and is not repeated in
#         the lookup, leaving us with 55 keys.
#
#        I've decided, on reading the spec, to construct proper morse
#        transmissions, with protocol signalling, as best I understand. As such
#        we prepend the <start transmission> and = section dividers, and end the
#        transmission with the cross + and <Invitation to Talk>
#
#         Throughout the code below there are references to the ITU
#         specification. Any numbered sections are lifted verbatim from that
#         source. All the transmutable special cases in the reference have been
#         dealt with. The character ‰ for 0/00 is the permille sign, parts per
#         thousand, or 10 basis points.
#
#         Its noteworthy that discounting the morse lookup table the program is
#         only 14 lines or so long. It relies heavily on list-wise operations so
#         its action is quite concise. Most of the heavy lifting is done in the
#         two lines creating the BCM lookup hash and the word-wise letter
#         translator.
#
#        A pipe can be used to connect the output here to the decoder, building a
#        tiny internal telegraph system within your machine. Try it, its fun:
#
#        [colincrain:~/Code/PWC]$  ./encode_binary_morse.pl | ./decode_binary_morse.pl
#
#        2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



# use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my %morse = (
    'a'    =>    '.-'    ,
    'b'    =>    '-...'  ,
    'c'    =>    '-.-.'  ,
    'd'    =>    '-..'   ,
    'e'    =>    '.'     ,
    'f'    =>    '..-.'  ,
    'g'    =>    '--.'   ,
    'h'    =>    '....'  ,
    'i'    =>    '..'    ,
    'j'    =>    '.---'  ,
    'k'    =>    '-.-'   ,
    'l'    =>    '.-..'  ,
    'm'    =>    '--'    ,
    'n'    =>    '-.'    ,
    'o'    =>    '---'   ,
    'p'    =>    '.--.'  ,
    'q'    =>    '--.-'  ,
    'r'    =>    '.-.'   ,
    's'    =>    '...'   ,
    't'    =>    '-'     ,
    'u'    =>    '..-'   ,
    'v'    =>    '...-'  ,
    'w'    =>    '.--'   ,
    'x'    =>    '-..-'  ,
    'y'    =>    '-.--'  ,
    'z'    =>    '--..'  ,
    'é'    =>    '..-..' ,
    '0'    =>    '-----'    ,
    '1'    =>    '.----'    ,
    '2'    =>    '..---'    ,
    '3'    =>    '...--'    ,
    '4'    =>    '....-'    ,
    '5'    =>    '.....'    ,
    '6'    =>    '-....'    ,
    '7'    =>    '--...'    ,
    '8'    =>    '---..'    ,
    '9'    =>    '----.'    ,
    q(")   =>    '.-..-.'   ,
    '('    =>    '-.--.'    ,
    ')'    =>    '-.--.-'   ,
    '+'    =>    '.-.-.'    ,
    ','    =>    '--..--'   ,
    '.'    =>    '.-.-.-'   ,
    '/'    =>    '-..-.'    ,
    '-'    =>    '-....-'   ,
    q(')   =>    '.----.'   ,
    ':'    =>    '---...'   ,
    '='    =>    '-...-'    ,
    '?'    =>    '..--..'   ,
    '@'    =>    '.--.–.'   ,
    '<End Transmission>'        =>   '...-.-'   ,
    '<Error>'                   =>   '........' ,
    '<Start Transmission>'      =>   '-.-.-'    ,
    '<Understood>'              =>   '...-.'    ,
    '<Wait>'                    =>   '.-...'    ,
);

## makes a new hash from %morse only this one has BCM as values
## BCM maps dot to 1, dash to 111, joined by 0, so:
##         "c" => "-.-."
## becomes:
##         "c" => "11101011101"
my %bcm = map { $_ => join '0', map { $_ eq '.' ? '1' : '111' } split //, $morse{$_}  } keys %morse;



my $input = <<__END__;
To be, or not to be- that is the question:
    Whether 'tis nobler in the mind to suffer
    The slings and arrows of outrageous fortune
    Or to take arms against a sea of troubles,
    And by opposing end them. To die- to sleep-
    No more; and by a sleep to say we end
    The heartache, and the thousand natural shocks
    That flesh is heir to. 'Tis a consummation
    Devoutly to be wish'd. To die- to sleep.
    To sleep- perchance to dream: ay, there's the rub!
    For in that sleep of death what dreams may come
    When we have shuffled off this mortal coil,
    Must give us pause. There's the respect
    That makes calamity of so long life.
    For who would bear the whips and scorns of time,
    Th' oppressor's wrong, the proud man's contumely,
    The pangs of despis'd love, the law's delay,
    The insolence of office, and the spurns
    That patient merit of th' unworthy takes,
    When he himself might his quietus make
    With a bare bodkin? Who would these fardels bear,
    To grunt and sweat under a weary life,
    But that the dread of something after death-
    The undiscover'd country, from whose bourn
    No traveller returns- puzzles the will,
    And makes us rather bear those ills we have
    Than fly to others that we know not of?
    Thus conscience does make cowards of us all,
    And thus the native hue of resolution
    Is sicklied o'er with the pale cast of thought,
    And enterprises of great pith and moment
    With this regard their currents turn awry
    And lose the name of action.- Soft you now!
    The fair Ophelia!- Nymph, in thy orisons
    Be all my sins rememb'red.
__END__



## input needs to first be sanitized and normalized to the spec:

# 4.3 A number that includes a fraction shall be transmitted with the
#     fraction linked to the whole number by a single hyphen.
$input =~ s/(\d+) (\d+\/\d+)/$1-$2/g;

# 3.3.1 To indicate the signal % or ‰, the figure 0, the fraction bar and the
#     figures 0 or 00 shall be transmitted successively (i.e. 0/0, 0/00).
# 3.3.2 A whole number, a fractional number, or a fraction, followed by a
#     % or ‰ sign, shall be transmitted by joining up the whole number, the
#     fraction number, or the fraction to the % or ‰ by a single hyphen.
#             Examples:   For 2%, transmit 2-0/0, and not 20/0.
#                         For 41/2‰, transmit 4-1/2-0/00, and not 41/20/00.
$input =~ s<%><-0/0>g;
$input =~ s<‰><-0/00>g;

# 3.5.1 To transmit the minute ( ′ ) or second ( ′′ ) signs, when such signs
#     follow figures – for example 1′15′′ – the apostrophe signal (. − − −
#     −.) must be used once or twice as appropriate. The signal (.− . . −.)
#     reserved for inverted commas may not be used for the second sign.
$input =~ s/′/'/g;

## allow only transmittable chars into the encoder.
## space isn't technically a signal in morse code per se (although the length of
## pause in the signal is codified, so perhaps it could be considered such as a
## special case) so we add it later in the grep
my $morse_character_class = q(-a-z0-9"()+,./':=?@);
my $processed_input = join '', grep { /[$morse_character_class]|\s/ } split //, lc($input);

## basic slice, dice and substitute method:
#      (this requires the entire message to be available at the beginning of encoding
#       to be stored in a strings and arrays of words and characters)

my @words = split /\s+/, $processed_input;

# 1.1.3 Starting signal (to precede every transmission) −.−.−
# II-3 The double hyphen (– . . . –) shall be transmitted either to separate:
#      3.1 the preamble from the service indications;
#      3.2 the service indications from each other;
#      3.3 the service indications from the address;
#      3.4 the station of destination from the text;
my @bcm_words = ('111010111010111', '1110101010111');  ## '<Start Transmission>', '='

## split the word, map to BCM signals and rejoin letters with 000 separator
for my $word ( @words ) {
    push @bcm_words, join '000', map { $bcm{$_} } split //, $word;
}

# II-6 The end of the transmission shall be indicated by the cross signal (.–.–.)
#     followed by the invitation to transmit signal K (–.–)
push @bcm_words, '1011101011101', '111010111';

## finally join the word list with separators and we are done
my $message = join '0000000', @bcm_words;

print STDOUT $message;
