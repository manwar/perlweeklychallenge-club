/*
Challenge 004
Challenge #1
Write a script to output the same number of PI digits as the size of your script.
Say, if your script size is 10, it should print 3.141592653.
https://crypto.stanford.edu/pbc/notes/pi/code.html
*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
char buf[1024];
int a=10000,b,c=2800,d,e,f[2801],g;
int main(int argc,char**argv){
for(;b-c;)f[b++]=a/5;
for(;d=0,g=c*2;c-=14,sprintf(buf+strlen(buf),"%.4d",e+d/a),e=d%a)
for(b=c;d+=f[b]*a,f[b]=d%--g,d/=g--,--b;d*=b);
a=argc==2?atoi(argv[1]):800;if(buf[a]>='5'){for(b=a-1;b>0;b--){
buf[b]++;if(buf[b]<='9')break;buf[b]--;}};buf[a]=0;
printf("%c.%s\n",buf[0],buf+1);
}
