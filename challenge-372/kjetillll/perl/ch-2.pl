use List::Util 'max';

sub f1 {
    my $max;
    shift =~ qr(
        (.) (.*) \1
        (??{ $max = max( $max, length $2 ); '^' })
    )x;
    $max
}

sub f2 {
    pop !~ /^(.)(.*\1)?/ ? 0 : max length($2) - 1, f2( $2 . $' )
}

print f1( $$_[0] ) == $$_[1] ? "ok\n" : "ERROR\n" and
print f2( $$_[0] ) == $$_[1] ? "ok\n" : "ERROR\n"
    for
    [ "aaaaa"     =>  3 ],
    [ "abcdeba"   =>  5 ],
    [ "abbc"      =>  0 ],
    [ "abcaacbc"  =>  4 ],
    [ "laptop"    =>  2 ],
    [ "yuwqrtywvenotetuhgonwehoftwnherothvpqwereartnpwertunvpwerutpwenrtiwerntvpwehgcfeo" => 70],
    #  __wqrtywvenotetuhgonwehoftwnherothvpqwereartnpwertunvpwerutpwenrtiwerntvpw_______
    [ "yuwqrtywvenotetuhgonwehoftwnherothvpqwereartnpwertunvpwerutpwenrtiwerntvpxehgcfeo" => 69],
    #  _________enotetuhgonwehoftwnherothvpqwereartnpwertunvpwerutpwenrtiwerntvpxehgcfe_
