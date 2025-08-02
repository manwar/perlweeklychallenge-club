sub count_common (@str1, @str2) {
    my $set1 = set @str1;
    my $set2 = set @str2;
    return ($set1 (&) $set2).elems;
}
