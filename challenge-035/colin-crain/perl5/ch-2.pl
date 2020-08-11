#! /opt/local/bin/perl
#
#        decode_binary_morse.pl
#
#        TASK #2
#         Write a program to decode binary morse code.
#         Consider how it might be possible to recover from badly formed morse code.
#
#             a) by splitting the morse code on gaps
#             b) without looking further than one digit ahead
#
#         method: if one has access to the entirety of the encoded message,
#             decoding by dividing it into it's component parts, translating
#             those back into dots and dashes, then doing reverse lookup and
#             reassembly is pretty straightforward. When building the BCM
#             encoder, it was necessary to build this component in order to
#             quickly check the quality of the output. So that is included
#             below, as
#
#                 decode_slice_and_dice($code, \%morse)
#
#             %morse is a 1:1 hash mapping letters to their morse signals, reversing
#             this hash creates a reverse lookup of signals to letters.
#
#             In the real world, however, morse transmissions just come down the
#             line, and the receiving station has no specific idea of its
#             length. It needs to be decoded as it comes, until the end of the
#             telegram is signalled with the '+', followed by the signal for the
#             letter K, for <Invitation to Talk>.
#
#             This task, of decoding the signal character-by-character as it
#             comes in, can be accomplished with a State Machine, which, knowing
#             it's current state, updates that state accordingly as each
#             character is read, reads the next and repeats until the input
#             signal terminates. First the BCM data is recorded in the state
#             until complete individual dots and dashes are transmitted. Next
#             those individual components are buffered into strings until the
#             character separation signal, 000, is sent and then the complete
#             morse signal is decoded into a character and output immediately.
#             Failure to find a lookup for a given signal results in resetting
#             the machine and substituting the _ character, not a normal valid
#             morse code output, to indicate the error and show placement.
#             Alternately, failure to interpret a valid state, such as produced
#             by passing two 0s followed by a 1, also produces an error state,
#             and similarly an underscore is output to indicate the error.
#
#        morse code is translated using the specifications made in:
#
#            Recommendation M.1677-1 (10/2009)
#
#        published by the International Telecommunications Union.
#
#        A pipe can be used to connect the input here to the encoder, building a
#        tiny internal telegraph system within your machine. Try it, its fun:
#
#        [colincrain:~/Code/PWC]$  ./encode_binary_morse.pl | ./decode_binary_morse.pl
#
#        2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



#use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $state = new State;
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
    '"'    =>    '.-..-.'   ,
    '('    =>    '-.--.'    ,
    ')'    =>    '-.--.-'   ,
    '+'    =>    '.-.-.'    ,
    ','    =>    '--..--'   ,
    '.'    =>    '.-.-.-'   ,
    '/'    =>    '-..-.'    ,
    '–'    =>    '-....-'   ,
    "'"    =>    '.----.'   ,
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
my %remorse = reverse %morse;

## set the input record separator to \1 to read a maximum of one character at a time
$/ = \1;

while (my $binary_signal = <STDIN>){

    ## null state: (0,0)
    #    set the Gap or Sig state value according to $binary_signal and get next input
    if ($state->is_null) {
        $binary_signal == 0 ? $state->gap_plusplus : $state->sig_plusplus;
        next;
    }

    ## signal off (gap) state: (+,0)
    #   token | action                          | new state
    #   ------+---------------------------------+----------
    #     0     Gap->++                            (++,0)
    #     1     dump_stream, Gap->0, Sig->1        (0,1)
    if ($state->state eq 'gap') {
        $binary_signal == 0 ? $state->gap_plusplus : dump_stream( $state, \%remorse );
    }
    ## signal on (sig) state: (0,+)
    #   token | action                          | new state
    #   ------+---------------------------------+----------
    #     0     dump_stream, Sig->0, Gap->1        (1,0)
    #     1     Sig->++                            (0,++)
    else {
        $binary_signal == 0 ? dump_stream( $state, \%remorse ) : $state->sig_plusplus;
    }

};

## flush remaining text from the buffers
dump_stream(   $state, \%remorse );
flush_buffers( $state, \%remorse );

## ## ## ## ## SUBS

sub dump_stream {
    my $s = shift;
    my $remorse = shift;

    if ($s->sig > 0) {                ## signal state actions
        if        ($s->sig == 1) {
            $s->{morse_buffer} .= '.';
            $s->toggle
        }
        elsif     ($s->sig == 3) {
            $s->{morse_buffer} .= '-';
            $s->toggle
        }
        else                     {     ## malformed BCM: cut bait, reset machine and recommence
            $s->error
        }
        return;
    }
    else {                            ## gap state actions
        if        ($s->gap == 1) {
            $s->toggle
        }
        elsif     ($s->gap == 3) {
            ## decode the character signal and add the letter to the word buffer and reset
            exists $remorse{ $s->{morse_buffer} } ?
                    print STDOUT $remorse{ $s->{morse_buffer} }
                    : $s->error;
            $s->{morse_buffer}  = '';
            $s->toggle;
        }
        elsif     ($s->gap == 7) {
            ## decode the character signal and add the letter to the word buffer and reset
            exists $remorse{ $s->{morse_buffer} } ?
                    print STDOUT $remorse{ $s->{morse_buffer} }
                    : $s->error;
            $s->{morse_buffer}  = '';
            print STDOUT " ";                                     ## insert space after word
            $s->toggle
        }
        else                    {
            $s->error
        }
    }
}

sub flush_buffers {
## output final flush of buffered signals and words
    my $s = shift;
    my $remorse = shift;
    exists $remorse{ $s->{morse_buffer} } ?
            print STDOUT $remorse{ $s->{morse_buffer} }, "\n"
            : $s->error;
}

sub decode_slice_and_dice {
## given a string of BCM, returns the decoded text string
## requires the entire BCM encoded message loaded into a string to operate
## convert to dashes first, then dots with remaining 1s, remove now-extraneous intracharacter spaces.
## divide on words, dice words into letters, decode each letter and reassemble words with spaces between
    my ($code, $morse) = @_;
    my %decode_morse = reverse $morse->%*;

    $code =~ s/111/-/g;
    $code =~ s/1/./g;
    $code =~ s/\b0\b//g;                    ## the intracharacter spaces can be removed
    my @words = split /0000000/, $code;
    my @out;
    for my $word ( @words ){
        my $text = join '', map { $decode_morse{$_} } split /000/, $word;
        push @out, $text;
    }
    return join ' ', @out;
}


## ## ## ## ## MODULES

package State;

sub new {
    my $class     = shift;
    my $self     = { "gap"             => 0,
                     "sig"             => 0,
                     "morse_buffer"    => '' };
    bless $self, $class;
    return $self;
}

sub gap { return $_[0]->{gap} };                    ## return gap value
sub sig { return $_[0]->{sig} };                    ## return sig value
sub msg { return $_[0]->{msg} };                    ## return message value

sub gap_plusplus { $_[0]->{gap}++ }                 ## increment gap value
sub sig_plusplus { $_[0]->{sig}++ }                 ## increment sig value

sub is_null {                                       ## state == null?
    if ($_[0]->{gap} == 0 && $_[0]->{sig} == 0) {
        return 1;
    }
    return 0;
}

sub error {
## malformed BCM: output _ char, reset machine and recommence
    my $s = shift;
    $s->{gap} = 0;
    $s->{sig} = 0;
    $s->{morse_buffer} = '';                        ## wipe the signal buffer
    print STDOUT '_';
}

sub state {
    my $state = shift;
    $state->gap > 0 && return 'gap';
    $state->sig > 0 && return 'sig';
}

sub toggle {                                        ## reset and switch state
    my $self = shift;
    if ($self->state eq 'gap')     { $self->{gap} = 0; $self->{sig} = 1 }
    else                           { $self->{gap} = 1; $self->{sig} = 0 }
}

1;


