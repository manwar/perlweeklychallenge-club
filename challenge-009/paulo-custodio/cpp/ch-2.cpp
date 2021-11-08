/*
Challenge 009

Challenge #2
Write a script to perform different types of ranking as described below:

1. Standard Ranking (1224): Items that compare equal receive the same ranking
   number, and then a gap is left in the ranking numbers.
2. Modified Ranking (1334): It is done by leaving the gaps in the ranking
   numbers before the sets of equal-ranking items.
3. Dense Ranking    (1223): Items that compare equally receive the same
   ranking number, and the next item(s) receive the immediately following
   ranking number.
*/

#include <algorithm>
#include <iostream>
#include <vector>
using namespace std;

struct Score {
    int seq;
    int score;
    int rank;
};

bool rev_by_score(const Score& a, const Score& b) {
    return a.score > b.score;
}

bool by_seq(const Score& a, const Score& b) {
    return a.seq < b.seq;
}

void standard_ranking(vector<Score>& scores) {
    sort(scores.begin(), scores.end(), rev_by_score);
    int rank = 1;
    for (size_t i = 0; i < scores.size(); i++) {
        int count = 0;
        for (size_t j = i; j < scores.size() && scores[i].score == scores[j].score; j++) {
            count++;
            scores[j].rank = rank;
        }
        rank += count;
        i += count - 1;
    }
    sort(scores.begin(), scores.end(), by_seq);
}

void modified_ranking(vector<Score>& scores) {
    sort(scores.begin(), scores.end(), rev_by_score);
    int rank = 1;
    for (size_t i = 0; i < scores.size(); i++) {
        int count = 0;
        for (size_t j = i; j < scores.size() && scores[i].score == scores[j].score; j++)
            count++;
        rank += count - 1;
        for (size_t j = i; j < scores.size() && scores[i].score == scores[j].score; j++)
            scores[j].rank = rank;
        rank++;
        i += count - 1;
    }
    sort(scores.begin(), scores.end(), by_seq);
}

void dense_ranking(vector<Score>& scores) {
    sort(scores.begin(), scores.end(), rev_by_score);
    int rank = 1;
    for (size_t i = 0; i < scores.size(); i++) {
        int count = 0;
        for (size_t j = i; j < scores.size() && scores[i].score == scores[j].score; j++) {
            count++;
            scores[j].rank = rank;
        }
        rank++;
        i += count - 1;
    }
    sort(scores.begin(), scores.end(), by_seq);
}


int main(int argc, char* argv[]) {
    if (argc < 2) return EXIT_FAILURE;
    vector<Score> scores;
    for (int i = 1; i < argc; i++) {
        Score s;
        s.seq = i;
        s.score = atoi(argv[i]);
        s.rank = 0;
        scores.push_back(s);
    }

    cout << "Data:             ";
    for (size_t i = 0; i < scores.size(); i++) {
        cout << scores[i].score;
        if (i + 1 < scores.size())
            cout << ", ";
    }
    printf("\n");

    standard_ranking(scores);
    cout << "Standard ranking: ";
    for (size_t i = 0; i < scores.size(); i++) {
        cout << scores[i].rank;
        if (i + 1 < scores.size())
            cout << ", ";
    }
    cout << endl;

    modified_ranking(scores);
    cout << "Modified ranking: ";
    for (size_t i = 0; i < scores.size(); i++) {
        cout << scores[i].rank;
        if (i + 1 < scores.size())
            cout << ", ";
    }
    cout << endl;

    dense_ranking(scores);
    cout << "Dense ranking:    ";
    for (size_t i = 0; i < scores.size(); i++) {
        cout << scores[i].rank;
        if (i + 1 < scores.size())
            cout << ", ";
    }
    cout << endl;
}
