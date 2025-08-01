%option noyywrap

%{
   #include <stdio.h>
   int count = 0; 
%}

/* Definitions */
digit         [0-9]
id            [A-Za-z]([A-Za-z0-9])*
ArithmeticOp  ("+"|"-"|"*"|"/"|"%")
BitwiseOp     ("<<" | ">>"| "^" | "|" | "&")
RelationalOp  ("<"|"=="|"<="|">"|">="|"!=")
LogicalOp     ("&&"|"||"|"!")
AssignOp      ("=")

%%
{id}           { printf("%s is identifier token\n", yytext); count++; }
{digit}+       { printf("%s is number token\n", yytext);     count++; }
{ArithmeticOp} { printf("%s is arithmetic operator token\n", yytext); count++; }
{RelationalOp} { printf("%s is relational operator token\n", yytext); count++; }
{LogicalOp}    { printf("%s is logical operator token\n", yytext);    count++; }
{AssignOp}     { printf("%s is assignment operator token\n", yytext); count++; }

[ \t\n]+       { /* ignore whitespace */ }
.              { printf("%s is unknown token\n", yytext); }
%%

int main() {
   printf("Enter the input: ");
   yylex();
   printf("Total no. of tokens are: %d\n", count);
   return 0;
}