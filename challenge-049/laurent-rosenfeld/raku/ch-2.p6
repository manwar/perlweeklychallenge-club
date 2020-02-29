use v6;
class LRU-cache {
    has %!cache;
    has @!order;
    has UInt $.capacity;

    method set (Int $key, Int $val) {
        %!cache{$key} = $val;
        push @!order, $key;
        if (@!order > $.capacity) {
            my $invalid = shift @!order;
            %!cache{$invalid}:delete;
        }
        self.display;
    };
    method get (Int $key) {
        return -1 unless %!cache{$key}:exists;
        @!order = grep { $_ != $key }, @!order;
        push @!order, $key;
        self.display;
        return %!cache{$key}
    };
    method display { .say for "Order: @!order[]", "Cache:\n{%!cache}" };
}

my $cache = LRU-cache.new(capacity => 3);
$cache.set(1, 3);
$cache.set(2, 5);
$cache.set(3, 7);
say "should print  5: ", $cache.get(2);
say "should print  3: ", $cache.get(1);
say "should print -1: ", $cache.get(4);
$cache.set(4, 9);
say "should print -1: ", $cache.get(3);
