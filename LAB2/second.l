%option noyywrap

%{
    #include <stdio.h>
    int count = 0;
%}


digit         [0-9]
id            [A-Za-z_][A-Za-z0-9_]*
Keyword       ("int"|"float"|"char"|"if"|"else"|"while"|"for"|"return"|"void"|"double"|"long"|"short")
ArithmeticOp  ("+"|"-"|"*"|"/"|"%")
RelationalOp  ("<"|"<="|">"|">="|"=="|"!=")
LogicalOp     ("&&"|"||"|"!")
AssignOp      ("=")
BitwiseOp     ("&"|"|"|"^"|"~"|"<<"|">>")

%%
{Keyword}      { printf("%s is a keyword\n", yytext);                       count++; }
{id}           { printf("%s is an identifier token\n", yytext);             count++; }
{digit}+       { printf("%s is a number token\n", yytext);                  count++; }
{ArithmeticOp} { printf("%s is an arithmetic operator token\n", yytext);    count++; }
{RelationalOp} { printf("%s is a relational operator token\n", yytext);     count++; }
{LogicalOp}    { printf("%s is a logical operator token\n", yytext);        count++; }
{AssignOp}     { printf("%s is an assignment operator token\n", yytext);    count++; }
{BitwiseOp}    { printf("%s is a bitwise operator token\n", yytext);        count++; }

[ \t\n]+       { }
.              { printf("%s is an unknown token\n", yytext); }
%%

int main() {
    printf("Enter the input: ");
    yylex();
    printf("Total no. of tokens are: %d\n", count);
    return 0;
}