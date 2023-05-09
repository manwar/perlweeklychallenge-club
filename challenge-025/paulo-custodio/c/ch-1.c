/*
Challenge 025

Generate a longest sequence of the following "English Pokemon" names where
each name starts with the last letter of previous name.
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include "utarray.h"

static const char* names[] = {
	"audino", "bagon", "baltoy", "banette", "bidoof", "braviary", "bronzor",
	"carracosta", "charmeleon", "cresselia", "croagunk", "darmanitan",
	"deino", "emboar", "emolga", "exeggcute", "gabite", "girafarig",
	"gulpin", "haxorus", "heatmor", "heatran", "ivysaur", "jellicent",
	"jumpluff", "kangaskhan", "kricketune", "landorus", "ledyba", "loudred",
	"lumineon", "lunatone", "machamp", "magnezone", "mamoswine", "nosepass",
	"petilil", "pidgeotto", "pikachu", "pinsir", "poliwrath", "poochyena",
	"porygon2", "porygonz", "registeel", "relicanth", "remoraid", "rufflet",
	"sableye", "scolipede", "scrafty", "seaking", "sealeo", "silcoon",
	"simisear", "snivy", "snorlax", "spoink", "starly", "tirtouga",
	"trapinch", "treecko", "tyrogue", "vigoroth", "vulpix", "wailord",
	"wartortle", "whismur", "wingull", "yamask"
};
int names_size = sizeof(names) / sizeof(char*);

UT_array* longest_seq;

void print_seq(UT_array* seq) {
	for (int* p = (int*)utarray_front(seq); p != NULL;
		p = (int*)utarray_next(seq, p)) {
		printf("%s ", names[*p]);
	}
	printf("\n");
}

void copy_seq(UT_array* dst, UT_array* src) {
	utarray_clear(dst);
	for (int* p = (int*)utarray_front(src); p != NULL;
		p = (int*)utarray_next(src, p)) {
		utarray_push_back(dst, p);
	}
}

char last_letter_seq(UT_array* seq) {
	char last_letter = '\0';
	if (utarray_len(seq) > 0) {
		const char* last_name = names[*(int*)utarray_back(seq)];
		last_letter = last_name[strlen(last_name) - 1];
	}
	return last_letter;
}

void find_longest_sequence(UT_array* seq, UT_array* pending) {
	char last_letter = last_letter_seq(seq);
	
	bool found_next = false;
	for (int* p = (int*)utarray_front(pending); p != NULL;
		p = (int*)utarray_next(pending, p)) {
		char first_letter = names[*p][0];
		
		if (last_letter == '\0' || last_letter == first_letter) {
			found_next = true;
			
			UT_array* new_seq;
			utarray_new(new_seq, &ut_int_icd);
			copy_seq(new_seq, seq);
			utarray_push_back(new_seq, p);

			UT_array* new_pending;
			utarray_new(new_pending, &ut_int_icd);
			copy_seq(new_pending, pending);
			utarray_erase(new_pending, p-(int*)utarray_front(pending), 1);
			
			find_longest_sequence(new_seq, new_pending);

			utarray_free(new_seq);
			utarray_free(new_pending);
		}
	}

	if (!found_next) {
		if (utarray_len(seq) > utarray_len(longest_seq)) {
			copy_seq(longest_seq, seq);
		}
	}
}

int main() {
	utarray_new(longest_seq, &ut_int_icd);

	UT_array* seq;
	utarray_new(seq, &ut_int_icd);

	UT_array* pending;
	utarray_new(pending, &ut_int_icd);
	for (int i = 0; i < names_size; i++)
		utarray_push_back(pending, &i);

	find_longest_sequence(seq, pending);
	print_seq(longest_seq);

	utarray_free(longest_seq);
	utarray_free(seq);
	utarray_free(pending);
}
