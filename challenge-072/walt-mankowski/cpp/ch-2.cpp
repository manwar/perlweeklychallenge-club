#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main(int argc, char *argv[]) {
    const string fname = argv[1];
    const int a = atoi(argv[2]);
    const int b = atoi(argv[3]);

    ifstream infile(fname);
    if (!infile) {
        perror(fname.c_str());
        exit(1);
    }

    int lineno = 1;
    string s;
    while (infile >> s) {
        if (a <= lineno && lineno <= b)
            cout << s << endl;
        lineno++;
        if (lineno > b)
            break;
    }
}
