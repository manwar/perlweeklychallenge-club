# Run as: sort temperature.txt | awk -f hot-day.awk
BEGIN {
    temp = 1000
    FS = ", "
}
{
    if ($2 > temp) {
        print $1
    }
    temp = $1
}
