multi sub MAIN (Str $string)                   # [1]
{
  my ($alphabet, $encoded) = encode($string);  # [2]
  say "'" ~ $alphabet ~ "' $encoded" ;         # [2]
}

multi sub MAIN (Str $alphabet, Str $binary)    # [3]
{
  say decode($alphabet, $binary);              # [4]
}

sub encode (Str $string)                              # [1]
{
  my @alphabet =  ('#', $string.comb).flat.unique;    # [2]
  my @dict     =  @alphabet;                          # [3]
  my %dict     =  @alphabet.kv.reverse;               # [4]

  my @chars = $string.comb;                           # [5]
  my $binary = "";                                    # [6]

  while @chars                                        # [7]
  {
    my $char = @chars.shift;                          # [8]

    last if $char eq "#";                             # [9]

    $char ~= @chars.shift while @chars.elems && %dict{$char ~ @chars[0]}; # [10]

    my $bits = @dict.elems.base(2).chars;             # [11]
    my $fmt  = '%0' ~ $bits ~ 'b';                    # [12]
    my $add  = %dict{$char}.fmt($fmt);                # [13]
    $binary ~= $add;                                  # [14]

    if @chars.elems && @chars[0] ne "#"               # [15]
    {
      @dict.push($char ~ @chars[0]);                  # [16]
      %dict{$char ~ @chars[0]} = @dict.end;           # [17]
    }
  }

  return @alphabet.join, $binary;                     # [18]
}

sub decode (Str $alphabet, Str $binary is copy)                           # [1]
{
  my @alphabet = $alphabet.comb;                                          # [2]

  @alphabet.unshift('#') unless @alphabet[0] eq "#";                      # [3]

  my $prev;                                                               # [4]
  my $output;                                                             # [5]

  while $binary.chars                                                     # [6]
  {
    my $size = (@alphabet.elems +1).base(2).chars;                        # [7]
    my $current = $binary.substr(0, $size);                               # [8]
    $binary.substr-rw(0, $size) = "";                                     # [9]

    my $value = @alphabet[$current.parse-base(2)];                        # [10]
    @alphabet.push($prev ~ $value) if $prev.defined;                      # [11]

    $output ~= $value;                                                    # [12]
    $prev = $value;                                                       # [13]
  }

  return $output;                                                         # [14]
}
