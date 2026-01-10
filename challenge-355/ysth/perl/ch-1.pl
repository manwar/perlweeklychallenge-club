use 5.036;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK1
use Inline C => <<'END_OF_C';
#include <inttypes.h>
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>

#define LOCALE "en_US.utf8"

SV *thousand_separator(unsigned long i) {

    char *oldlocale = setlocale(LC_NUMERIC, NULL);
    if (NULL == setlocale(LC_NUMERIC, LOCALE)) {
        fprintf(stderr, "Unable to set locale to %s\n", LOCALE);
        exit(EXIT_FAILURE);
    }
    char buffer[27];
    snprintf(buffer, sizeof(buffer), "%'lu", i);
    setlocale(LC_NUMERIC, oldlocale);

    return newSVpv(buffer,0);
}

END_OF_C

unless (caller) {
    require Run::WeeklyChallenge;
    require Cpanel::JSON::XS;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { Cpanel::JSON::XS->new->ascii->allow_nonref->encode(thousand_separator($inputs)) },
        '123',
        '{"type": "integer", "minimum": 1}',
    );
}
