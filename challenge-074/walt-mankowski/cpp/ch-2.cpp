#include <string>
#include <iostream>
#include <map>
#include <list>

using namespace std;

int main(int argc, char *argv[]) {
    const string s(argv[1]);
    string out = string(s.length(), ' ');
    map<char,list<char>::const_iterator> seen;
    list<char> nr;

    for (size_t i = 0; i < s.length(); i++) {
        const char c = s[i];
        
        // have we seen c before?
        if (seen.find(c) == seen.end()) {
            nr.push_front(c);
            seen[c] = nr.cbegin();
        } else {
            // remove c from nr
            if (seen[c] != nr.end()) {
                nr.erase(seen[c]);
                seen[c] = nr.end();
            }
        }

        // now the FNR is either the last element of nr, or #
        if (nr.empty()) 
            out[i] = '#';
        else
            out[i] = *(nr.cbegin());
    }
    cout << out << endl;                
}
