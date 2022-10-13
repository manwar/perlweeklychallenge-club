sub makeover ($in) {
    return $in.samemark('a');
}
for 'ÃÊÍÒÙ', 'âÊíÒÙ', 'àçùòîéèûä' -> $test {
    say "$test -> \t", makeover($test);
}
