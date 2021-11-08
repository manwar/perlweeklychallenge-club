/*
Challenge 010

Challenge #2
Write a script to find Jaro-Winkler distance between two strings. For more
information check wikipedia page.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXLINE 1024

#define MIN(a,b)    ((a)<(b)?(a):(b))
#define MAX(a,b)    ((a)>(b)?(a):(b))

float jaro_similarity(const char* s1, const char* s2) {
    if (strcmp(s1, s2) == 0) return 1.0;    // equal strings

    int len1 = strlen(s1);
    int len2 = strlen(s2);

    // max distance between matching characters
    int max_dist = (MAX(len1, len2) / 2) - 1;

    // count number of unique matches - same letters less than max_dist appart
    int match = 0;
    char found_s1[MAXLINE]; memset(found_s1, 0, sizeof(found_s1));
    char found_s2[MAXLINE]; memset(found_s2, 0, sizeof(found_s2));

    for (int i = 0; i < len1; i++) {
        int min_j = MAX(0, i - max_dist);
        int max_j = MIN(len2-1, i + max_dist);
        for (int j = min_j; j <= max_j; j++) {
            if (s1[i] == s2[j] && !found_s2[j]) {   // same and not already matched
                found_s1[i] = 1;                    // mark as found
                found_s2[j] = 1;
                match++;
                break;
            }
        }
    }

    if (match == 0) return 0.0;                     // no matches

    // count transpositions : The first assigned character on one string is
    // compared to the first assigned character on the other string.If the
    // characters are not the same, half of a transposition has occurred.Then
    // the second assigned character on one string is compared to the second
    // assigned character on the other string, etc.The number of mismatched
    // characters is divided by two to yield the number of transpositions.
    float transp = 0.0;
    int pos_s2 = 0;
    for (int i = 0; i < len1; i++) {
        if (found_s1[i]) {      // there is a match in s1, find first match in s2
            while (!found_s2[pos_s2] && pos_s2 < len2)
                pos_s2++;
            if (s1[i] != s2[pos_s2++])
                transp++;
        }
    }
    transp /= 2;

    float js = ((float)match / (float)len1
        + (float)match / (float)len2
        + ((float)match - (float)transp) / (float)match) / 3.0f;
    return js;
}

float jaro_winkler_similarity(const char* s1, const char* s2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    // find longest common prefix l
    int l = 0;
    while (l < MIN(4, MIN(len1, len2)) && s1[l] == s2[l])
        l++;

    // constant p
    float p = 0.1f;

    float js = jaro_similarity(s1, s2);
    float jws = js + l * p * (1 - js);
    return jws;
}

float jaro_winkler_distance(const char* s1, const char* s2) {
    return 1.0f - jaro_winkler_similarity(s1, s2);
}


int main(int argc, char* argv[]) {
    if (argc != 3) return EXIT_FAILURE;
    printf("%.2f\n", jaro_winkler_distance(argv[1], argv[2]));
}
