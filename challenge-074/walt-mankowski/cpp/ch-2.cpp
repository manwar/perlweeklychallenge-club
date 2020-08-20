#include <string.h>
#include <iostream>
#include <map>
#include <list>
#include <algorithm>

using namespace std;

int main(int argc, char *argv[]) {
    const char *s = argv[1];
    map<char,list<char>::const_iterator> seen;
    list<char> nr;
    char *out = new char[strlen(s)+1];
    out[strlen(s)] = '\0';

    for (size_t i = 0; i < strlen(s); i++) {
        const char c = s[i];
        
        // have we seen c before?
        if (seen.find(c) == seen.end()) {
            nr.push_front(c);
            seen[c] = nr.cbegin();
        } else
            // remove c from nr
            nr.erase(seen[c]);

        // now the FNR is either the last element of nr, or #
        if (nr.empty()) 
            out[i] = '#';
        else
            out[i] = *(nr.cbegin());
    }
    cout << out << endl;                
}
