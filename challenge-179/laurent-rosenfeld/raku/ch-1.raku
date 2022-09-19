use Lingua::EN::Numbers;

for 11, 62, 99 -> $num {
    say "$num => ", ordinal($num);
}
