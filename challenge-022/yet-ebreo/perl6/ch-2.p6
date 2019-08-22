# Write a script to implement Lempel–Ziv–Welch (LZW) compression algorithm.
# The script should have method to encode/decode algorithm.
# The wiki page explains the compression algorithm very nicely.

constant INIT_DICT_SIZE = 255;

sub encode (Str $string){
    my Int $len     = $string.chars;
    #Initialize the dictionary to hash
    my $dict_size   = INIT_DICT_SIZE;
    my %dictionary  = map { $_.chr => $_ }, 0..$dict_size;

    my Str $prev    = $string.substr: 0,1;
    my Str $curr    = "";

    my Int $code    = INIT_DICT_SIZE+1;
    my @buff_out    = ();

    for 0..$len-1 -> $i {
        if ($i != $len-1) {
            $curr ~= $string.substr: $i + 1,1;
        }
        if (%dictionary{$prev~$curr}:exists) {
            $prev ~= $curr;
        } else {

            push @buff_out, %dictionary{$prev};
            %dictionary{$prev~$curr} = $code;
            $code++;
            $prev = $curr;
        }
        $curr = "";
    }
    push @buff_out, %dictionary{$prev};
    return @buff_out;
}

sub decode (Int @buff_in){

    #Initialize dictionary using numbers as keys
    #Using array would work too
    my %dictionary  = map { $_ => $_.chr }, 0..INIT_DICT_SIZE;

    #Initialize the first value from @buff_in to $o
    my $o           = @buff_in[0];
    my $n           = "";
    my $s           = %dictionary{$o};
    my $c           = $s.substr: 0, 1;
    my $ret         = $s;

    my $count       = INIT_DICT_SIZE;

    #Go through the codes in @buff_in
    for 0..@buff_in.end-1 -> $i  {

        #Store the $n-ext value
        $n = @buff_in[$i+1];

        #Check if $n-ext value is in the dictionary
        if ( %dictionary{$n}:exists ) {
            $s = %dictionary{$n};
        } else {
            $s = %dictionary{$o};
            $s~= $c;
        }

        #Update return value
        $ret ~= $s;
        $c = $s.substr: 0, 1;

        #Update dictionary
        %dictionary{++$count} = %dictionary{$o}~$c;

        #Update store $n to $o as
        #new value becomes old and be replaced on next iteration
        $o = $n;
    }
    return $ret;
}
my $original = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
say "Original String has length "~$original.chars;
say $original;

my Int @compressed = encode($original);
say "\nCompressed String has length "~(map {$_.chr},@compressed).join.chars;
say (map {$_.chr},@compressed).join;

my $uncompressed = decode(@compressed);
say "\nUncompressed String has length "~($uncompressed.chars);
say "$uncompressed";

if ($uncompressed eq $original) {
    say "\nUncompressed string matches original";
}
