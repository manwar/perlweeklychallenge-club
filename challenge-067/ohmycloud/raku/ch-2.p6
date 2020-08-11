sub MAIN(Str $s) {
    my %h =
        2 => 'abc',
        3 => 'def',
        4 => 'ghi',
        5 => 'jkl',
        6 => 'mno',
        7 => 'pqrs',
        8 => 'tuv',
        9 => 'wxyz';

    my $r = $s.trans('01' => '');
    if $r.chars > 0 {
        say unique [X~] %h{$r.comb}».comb;
    } else {
        say [];
    }
}
