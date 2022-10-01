for <ab1234 cd5678 ef1342>, <pq1122 rs3334> -> @test {
    my $i = 0;
    my @out;
    for @test {
        push @out, .subst(/^<[a..z]>**2/, $i.fmt("%02d"));
        $i++;
    }
    say "@test[]  =>  @out[]";
}
