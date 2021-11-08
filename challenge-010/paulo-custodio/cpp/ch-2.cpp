/*
Challenge 010

Challenge #2
Write a script to find Jaro-Winkler distance between two strings. For more
information check wikipedia page.
*/

#include <iostream>
#include <string>
#include <cmath>
using namespace std;

float jaro_similarity(const string& s1, const string& s2) {
    if (s1 == s2) return 1.0;    // equal strings

    int len1 = static_cast<int>(s1.size());
    int len2 = static_cast<int>(s2.size());

    // max distance between matching characters
    int max_dist = (max(len1, len2) / 2) - 1;

    // count number of unique matches - same letters less than max_dist appart
    int match = 0;
    bool found_s1[len1] = {0};
    bool found_s2[len2] = {0};

    for (int i = 0; i < len1; i++) {
        int min_j = max(0, i - max_dist);
        int max_j = min(len2-1, i + max_dist);
        for (int j = min_j; j <= max_j; j++) {
            if (s1[i] == s2[j] && !found_s2[j]) {   // same and not already matched
                found_s1[i] = true;                 // mark as found
                found_s2[j] = true;
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

float jaro_winkler_similarity(const string& s1, const string& s2) {
    int len1 = static_cast<int>(s1.size());
    int len2 = static_cast<int>(s2.size());

    // find longest common prefix l
    int l = 0;
    while (l < min(4, min(len1, len2)) && s1[l] == s2[l])
        l++;

    // constant p
    float p = 0.1f;

    float js = jaro_similarity(s1, s2);
    float jws = js + l * p*(1 - js);
    return jws;
}

float jaro_winkler_distance(const string& s1, const string& s2) {
    return 1.0f - jaro_winkler_similarity(s1, s2);
}


int main(int argc, char* argv[]) {
    if (argc != 3) return EXIT_FAILURE;
    float jwd = jaro_winkler_distance(argv[1], argv[2]);
    jwd = round(jwd*100.0f)/100.0f;     // show 2 decimals
    cout << jwd << endl;
}
