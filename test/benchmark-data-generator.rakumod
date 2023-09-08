unit module benchmark-data-generator:ver<0.0.1>:auth<rcmlz@github.com)>;

my @problem-size-factor-ten = 1,10,100,1000,10000 ... Inf;
my @problem-size-factor-two = 1,2,4,8,16,32 ... Inf;
my Set $some-unicode-characters = 
                   ('a'..'z') ∪ ('A'..'Z') ∪ (0..9) ∪ 
                   ('∪', '∅', '∩', '⊖') ∪
                   ("\c[VULGAR FRACTION ONE HALF]", "\c[VULGAR FRACTION ONE SEVENTH]", "\c[VULGAR FRACTION ONE FIFTH]") ∪
                   ("\c[Roman Numeral Four]", "\c[Roman Numeral Three]", "\c[Roman Numeral Two]", "\c[Roman Numeral One]") ∪ 
                   ('à', 'è', 'ä', 'ö', 'ü', 'Ä', 'Ö', 'Ü', 'ß', "\c[LATIN CAPITAL LETTER SHARP S]") ∪ 
                   ("\c[PENGUIN]", "\c[BELL]", "\c[SMILING FACE WITH HALO]", "\c[GRINNING FACE]") ∪ 
                   ("\c[EGYPTIAN HIEROGLYPH A001]" .. "\c[EGYPTIAN HIEROGLYPH A004]");         


sub data-provider-for(Str $challenge, Str $task-string) is export {
    my &d;
    given $challenge => $task-string {
        when 'nr233' => 'task-one' { &d = &unicode-words.assuming(*, 10, 1, 25) }
        when 'nr233' => 'task-two' { &d = &integers.assuming(*, -100, 100) }
        when 'DEMO' => 'task-one'  { &d = &data-task-template}
        when 'DEMO' => 'task-two'  { &d = &data-task-template}
        default {die "Data provider for $challenge $task-string not implemented."}
    }
    return &d;
}

sub unicode-words(UInt $entry, UInt $alphabet-size, UInt $min-length, UInt $max-length where {$min-length <= $max-length}) {
    
    state @data is default([]);
    
    my $n = @problem-size-factor-two[$entry];
    my $word-lenght = $min-length .. $max-length;
    
    unless @data[$n].elems {
        my Str @this-data;
        my @alphabet = $some-unicode-characters.roll($alphabet-size);
        @this-data.push: @alphabet.roll($word-lenght.roll).join('') for ^$n;
        @data[$n] = @this-data;
    }
    return @data[$n];
}

sub integers(UInt $entry, Int $min, Int $max where {$min <= $max}) {
    state @data is default([]);
    my $n = @problem-size-factor-two[$entry];
    @data[$n] = ($min..$max).roll($n) unless @data[$n].elems;
    return @data[$n];
}

sub data-task-template(UInt $entry) {
    state @data is default([]);
    my $n = @problem-size-factor-ten[$entry];
    @data[$n] = ^($n) unless @data[$n].elems;
    return @data[$n];
}
