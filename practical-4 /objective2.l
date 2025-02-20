%{
#include <stdio.h>
%}

%%
[Cc][Hh][Aa][Rr][Uu][Ss][Aa][Tt] { printf("university"); }
. { putchar(yytext[0]); }
%%

int main() {
    yylex();  // Start lexical analysis
    return 0;
}

int yywrap() {
    return 1;  // End of input
}