%option noyywrap

%{
    #include <iostream>
    using namespace std;
%}

%%
[ \t]                ; /* ignore spaces */
[0-9]+\.[0-9]+       { cout << "Found a Floating-point number: " <<yytext << endl; }
[0-9]+               { cout << "Found an Integer : " << yytext << endl; }
[a-zA-Z0-9]+         { cout << "Found a String: " << yytext << endl; }
%%

int main(){
    yylex();
}