%option noyywrap

%{
    #include <stdio.h>
%}

%%
[a-zA-Z]+[a-zA-Z0-9]*    { printf("%s is an identifier\n", yytext); }
.                       { printf("%s is NOT an identifier\n", yytext); }
%%

int main(void)
{
    printf("Enter input (Ctrl+D to end):\n");
    yylex();
    return 0;
}