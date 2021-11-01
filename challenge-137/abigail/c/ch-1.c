# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

short start_years       [] = {1600, 2000};
short long_year_offsets [] = {
      4,      9,     15,     20,     26,
     32,     37,     43,     48,     54,
     60,     65,     71,     76,     82,
     88,     93,     99,            
            105,    111,    116,    122,
    128,    133,    139,    144,    150,
    156,    161,    167,    172,    178,
    184,    189,    195,            
            201,    207,    212,    218,
    224,    229,    235,    240,    246,
    252,    257,    263,    268,    274,
    280,    285,    291,    296,    
                    303,    308,    314,
    320,    325,    331,    336,    342,
    348,    353,    359,    364,    370,
    376,    381,    387,    392,    398
};

int main (void) {
    for (size_t i = 0; i < 2; i ++) {
        for (size_t j = 0; j < 71; j ++) {
            short year = start_years [i] + long_year_offsets [j];
            if (1900 <= year && year <= 2100) {
                printf ("%d\n", year);
            }
        }
    }
}
