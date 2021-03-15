# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

/*
 * We're reading years from standard input, one year per line, outputting
 * years from the sexagenary cycle [1]. This is slightly more than what
 * the challenge ask; the challenge asks to output the heavenly stem [2],
 * and the earthly branch [3]. But we also output its Yin/Yang.
 *
 * [1] https://en.wikipedia.org/wiki/Sexagenary_cycle
 * [2] https://en.wikipedia.org/wiki/Heavenly_Stems
 * [3] https://en.wikipedia.org/wiki/Earthly_Branches
 *

 *
 * Each of the cycles have been rotated so the first entry corresponds to
 * the year 0 in the Proleptic Gregorian calendar. (We're using the
 * convention of having a year 0, as per ISO 8601).
 * That way, we can just mod the year with the number of entries, without
 * first having to subtract something from the year.
 *
 * The heavenly stems last for 2 years, so we just duplicate the entries.
 */

char * yin_yang         [ 2] = {"Yang",   "Yin"};
size_t yin_yang_size         =   2;
char * heavenly_stems   [10] = {"Metal",  "Metal",   "Water", "Water",
                                "Wood",   "Wood",    "Fire",  "Fire",
                                "Earth",  "Earth"};
size_t heavenly_stems_size   =  10;
char * earthly_branches [12] = {"Monkey", "Rooster", "Dog",   "Pig",
                                "Rat",    "Ox",      "Tiger", "Rabbit",
                                "Dragon", "Snake",   "Horse", "Goat"};
size_t earthly_branches_size =  12;



int main (void) {
    int year;

    while (scanf ("%d", &year) == 1) {
        printf ("%s %s %s\n", yin_yang         [year % yin_yang_size],
                              heavenly_stems   [year % heavenly_stems_size],
                              earthly_branches [year % earthly_branches_size]);
    }

    return (0);
}
