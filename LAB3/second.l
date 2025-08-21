%option noyywrap

%{
    #include <stdio.h>
    int normal_words = 0;
    int double_comment_words = 0;
    int single_comment_words = 0;
%}

%x COMMENT
%x SINGLECOMMENT

%%
"/*"                                   { BEGIN(COMMENT); }
<COMMENT>"*/"                          { BEGIN(INITIAL); }
"//"                                   { BEGIN(SINGLECOMMENT); }
<SINGLECOMMENT>"\n"                    { BEGIN(INITIAL); }

[a-zA-Z]+                              { normal_words++; printf("Normal word: %s\n", yytext);       }
<COMMENT>[a-zA-Z0-9]+                  { double_comment_words++; printf("Comment Word: %s\n", yytext);     }
<SINGLECOMMENT>[a-zA-Z0-9]+            { single_comment_words++; printf("Comment Word: %s\n", yytext);     }

[ \t\n]                                ; /*ignore whitespace*/
.                                      ; /* ignore everthing else */
<COMMENT>.                             ; /* ignore everthing else */
%%

int main(){
    yylex();
    printf("Normal Words: %d\n", normal_words);
    printf("Comment Words: %d\n", double_comment_words + single_comment_words);
    return 0;
}