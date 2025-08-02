sub max-pairs(@words) {
    my %word-set = @words.map: { $_ => True };
    my $count = [+] @words.map: { %word-set{.flip}:exists };
    return $count div 2;
}

# Tests
use Test;
is max-pairs(<ab de ed bc>), 1, 'Test 1';
is max-pairs(<aa ba cd ed>), 0, 'Test 2';
is max-pairs(<uv qp st vu mn pq>), 2, 'Test 3';
done-testing();
