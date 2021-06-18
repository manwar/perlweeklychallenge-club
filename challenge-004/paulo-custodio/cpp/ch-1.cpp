/*
Challenge 004
Challenge #1
Write a script to output the same number of PI digits as the size of your script.
Say, if your script size is 10, it should print 3.141592653.
https://crypto.stanford.edu/pbc/notes/pi/code.html
*/
#include <iostream>
#include <iomanip>
#include <sstream>
using namespace std;
ostringstream buf;int a=10000,b,c=2800,d,e,f[2801],g;
int main(int argc,char**argv){
for(;b-c;)f[b++]=a/5;
for(;d=0,g=c*2;c-=14,(buf<<setw(4)<<setfill('0')<<e+d/a),e=d%a)
for(b=c;d+=f[b]*a,f[b]=d%--g,d/=g--,--b;d*=b);
a=argc==2?atoi(argv[1]):800;string s=buf.str();if(s[a]>='5'){for(b=a-1;b>0;b--){
s[b]++;if(s[b]<='9')break;s[b]--;}};s.resize(a);
cout<<s[0]<<'.'<<s.c_str()+1;
}
