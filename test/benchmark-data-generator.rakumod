unit module benchmark-data-generator:ver<0.0.1>:auth<rcmlz@github.com)>;

state @problem-size-factor-ten = 1,10,100,1000,10000 ... Inf;
state @problem-size-factor-two = 1,2,4,8,16,32 ... Inf;
    
sub data-provider-for($challenge, Str $task-string) is export {
    return &random-strings if ('nr233', 'task-one') ~~ ($challenge, $task-string);
    return &random-integers if ('nr233', 'task-two') ~~ ($challenge, $task-string);


    return &data-task-template if ('DEMO', 'task-one') ~~ ($challenge, $task-string);
    return &data-task-template if ('DEMO', 'task-two') ~~ ($challenge, $task-string);

    die "Data provider for $challenge $task-string not implemented.";
}

sub random-strings($entry, $min-length=1, $max-length=100) {
    state @data is default([]);
    
    my $n = @problem-size-factor-two[$entry];
    
    my $alphabet = ('a'..'z') ∪ ('A'..'Z') ∪ (0..9) ∪ 
                   ('à', 'è.', 'ä', 'ö', 'ü', 'Ä', 'Ö', 'Ü', 'ß', "\c[LATIN CAPITAL LETTER SHARP S]") ∪ 
                   ("\c[PENGUIN]", "\c[BELL]", "\c[SMILING FACE WITH HALO]", "\c[GRINNING FACE]") ∪ 
                   ("\c[EGYPTIAN HIEROGLYPH A001]" .. "\c[EGYPTIAN HIEROGLYPH B009]");         
    
    my $word-lenght = $min-length .. $max-length;
    
    unless @data[$n].elems {
        my @this-data;
        @this-data.push: $alphabet.roll($word-lenght.roll).join('') for ^$n;
        @data[$n] = @this-data;
    }
    return @data[$n];
}

sub random-integers($entry, $min=-100, $max=100) {
    state @data is default([]);
    my $n = @problem-size-factor-two[$entry];
    @data[$n] = ($min..$max).roll($n) unless @data[$n].elems;
    return @data[$n];
}

sub data-task-template($entry) {
    state @data is default([]);
    my $n = @problem-size-factor-ten[$entry];
    @data[$n] = ^($n) unless @data[$n].elems;
    return @data[$n];
}
