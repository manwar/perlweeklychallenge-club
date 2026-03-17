// Perl Weekly Challenge 247 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-247/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    const char* name;
    bool has_given;
    bool has_received;
} Person;

bool same_family(const char* person1, const char* person2) {
    const char* name1 = strchr(person1, ' ');
    if (name1 == NULL)
        return false;
    const char* name2 = strchr(person2, ' ');
    if (name2 == NULL)
        return false;
    if (strcmp(name1, name2) == 0)
        return true;
    else
        return false;
}

StrArray* distribute_presents(StrArray* people) {
    // pairs of (giver, receiver)
    StrArray* pairs = strarray_new();

    // make list of people with attributes
    Person* persons = xmalloc(people->size * sizeof(Person));
    for (int i = 0; i < people->size; i++) {
        persons[i].name = people->data[i];
        persons[i].has_given = false;
        persons[i].has_received = false;
    }

    // attribute presents
    while (true) {
        // get the first that has not given
        int giver = 0;
        for (; giver < people->size; giver++) {
            if (!persons[giver].has_given)
                break;
        }
        if (giver == people->size)
            break;          // finished

        // get the first that has not received and is not the same family
        int receiver = 0;
        for (; receiver < people->size; receiver++) {
            if (receiver != giver &&
                !persons[receiver].has_received &&
                !same_family(persons[giver].name, persons[receiver].name))
                break;
        }
        if (receiver == people->size) {
            // must relax the rule
            receiver = 0;
            for (; receiver < people->size; receiver++) {
                if (receiver != giver &&
                    !persons[receiver].has_received)
                    break;
            }
            if (receiver == people->size)
                die("cannot find a receiver for %s", persons[giver].name);
        }

        // make the assignment
        strarray_push_back(pairs, persons[giver].name);
        strarray_push_back(pairs, persons[receiver].name);
        persons[giver].has_given = true;
        persons[receiver].has_received = true;
    }

    // free persons
    xfree(persons);

    return pairs;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s people...", argv[0]);

    StrArray* people = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(people, argv[i]);

    StrArray* pairs = distribute_presents(people);
    for (int i = 0; i < pairs->size; i += 2)
        printf("%s -> %s\n", pairs->data[i], pairs->data[i+1]);

    strarray_free(people);
    strarray_free(pairs);
}
