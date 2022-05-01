#!/usr/bin/env raku

sub preprocess-text($_) {
  .lc.trans('j' => 'i', ' ' => '')
}

sub round-even($_) {
  .chars %% 2 ?? $_ !! $_ ~ 'x'
}

sub build-table-flat($keyphrase) {
  my @head = $keyphrase.&preprocess-text.comb.unique;
  (|@head, (('a'..'i', 'k'..'z') (-) @head andthen .keys.sort.Slip))
}

enum Mode<Encrypt Decrypt>;

sub same-row(@table, $a, $b) {
  my Int() $size = @table.sqrt;
  .first($a, :k) div $size == .first($b, :k) div $size given @table
}

sub same-column(@table, $a, $b) {
  my Int() $size = @table.sqrt;
  .first($a, :k) mod $size == .first($b, :k) mod $size given @table
}

sub move-in-row(@table, $mode, $value) {
  my Int() $size = @table.sqrt;
  my $flat-index = @table.first($value, :k);
  my ($direction, $overflown-column) = $mode == Encrypt ?? (1, 0) !! (-1, $size - 1);
  $flat-index += 1 * $direction;
  $flat-index -= $size * $direction if $flat-index mod $size == $overflown-column;
  @table[$flat-index]
}

sub move-in-column(@table, $mode, $value) {
  my Int() $size = @table.sqrt;
  my $flat-index = @table.first($value, :k);
  my ($direction, $overflown-row) = $mode == Encrypt ?? (1, $size) !! (-1, -1);
  $flat-index += $size * $direction;
  $flat-index -= $size * $size * $direction if $flat-index div $size == $overflown-row;
  @table[$flat-index]
}

proto process-pair(@table, $mode, $a, $b) {*}
multi process-pair(@table, $mode, 'x', 'x') { nextwith @table, $mode, 'x', 'q' }
multi process-pair(@table, $mode, $a, $b where $a eq $b) { nextwith @table, $mode, $a, 'x' }
multi process-pair(@table, $mode, $a, $b where same-row(@table, $a, $b)) {
  [~] ($a, $b).map({ move-in-row(@table, $mode, $_) })
}
multi process-pair(@table, $mode, $a, $b where same-column(@table, $a, $b)) {
  [~] ($a, $b).map({ move-in-column(@table, $mode, $_) })
}
multi process-pair(@table, $, $a, $b) {
  my Int() $size = @table.sqrt;
  my @positions = (($a, $b).map({ @table.first($_, :k) andthen ($_ div $size, $_ mod $size) })
    andthen ([Z] $_)
    andthen (.[0] Z .[1].reverse));
  @table[@positions.map({ .[0] * $size + .[1] }).Slip].join
}

sub encrypt-decrypt($mode, $cipher, $text) {
  my @table = build-table-flat $cipher;
  dd @table;
  [~] $text.&preprocess-text.&round-even.comb.map(&process-pair.assuming: @table, $mode, *, *)
}

constant &encrypt = &encrypt-decrypt.assuming: Encrypt;
constant &decrypt = &encrypt-decrypt.assuming: Decrypt;

say encrypt("playfair example", "hide the gold in the tree stump");
say decrypt("perl and raku", "siderwrdulfipaarkcrw");