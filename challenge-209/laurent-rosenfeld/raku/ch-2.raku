sub merge-account (@in) {
    my %merged;
    for @in -> @part {
        my ($key, @values) = @part;
        %merged{$key}{$_} = True for @values;
    }
    return %merged;
}

my @tests = ( <A a1@a.com a2@a.com>,
              <B b1@b.com>,
              <A a3@a.com a1@a.com> ),
            ( <A a1@a.com a2@a.com>,
              <B b1@b.com>,
              <A a3@a.com>,
              <B b2@b.com b1@b.com> );
for @tests -> @test {
    say @test, " => ";
    my %merged = merge-account @test;
    for %merged.keys.sort -> $k {
        say "\t[", (join " ", $k, |%merged{$k}.keys.sort), "]";
    };
    say "";
}
