#! /usr/bin/env raku

my @names20 = <zero one two three four five six seven eight nine
               ten eleven twelve thirteen fourteen fifteen sixteen 
               seventeen eighteen nineteen>;
              
my @tens = <twenty thirty forty fifty sixty seventy eighty ninety>;

my @zillions = [
    [10 ** 3,  'thousand'],
    [10 ** 6,  'million' ],
    [10 ** 9,  'billion' ],
    [10 ** 12, 'trillion'],
    # ... add as you need ...
];

multi num-to-en($number where * < 20) {
    @names20[$number]
}

multi num-to-en($number where * < 100) {
    my $end := $number % 10 ?? '-' ~ num-to-en $number % 10 !! '';
    @tens[($number div 10) - 2] ~ $end
}

multi num-to-en($number where * < 1000) {
    my $prefix := num-to-en($number div 100) ~ ' hundred';
    my $end := $number % 100 ?? ' ' ~ num-to-en $number % 100 !! '';
    $prefix ~ $end
}

multi num-to-en($number where * < @zillions.tail.head) {
    my ($value, $name) = @zillions.grep(*.head < $number).sort.tail;
    my $prefix := num-to-en($number div $value) ~ " $name";
    my $end := $number % $value ?? ' ' ~ num-to-en($number % $value) !! '';
    $prefix ~ $end
}

say (@*ARGS.head // 42).subst: /((\d)$0*)/, {"{num-to-en $0.chars} $0[0] "}, :g;
