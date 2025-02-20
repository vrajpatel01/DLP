%{
#include <stdio.h>
#include <string.h>

#define MAX_KEYWORDS 10

const char *keywords[MAX_KEYWORDS] = {
    "int", "char", "float", "double", "return",
    "void", "if", "else", "for", "while"
};

int is_keyword(const char *str) {
    int i;
    for (i = 0; i < MAX_KEYWORDS; i++) {
        if (strcmp(str, keywords[i]) == 0) {
            return 1;
        }
    }
    return 0;
}
%}

%%
"//".*           {/* Ignore single-line comments */}
"/*"([^*]|\*+[^*/])*\*+"/" {/* Ignore multi-line comments */}
"'"[^']"'"       { printf("String: %s\n", yytext); }
\"[^\"]*\"       { printf("String: %s\n", yytext); }
[0-9]+           { printf("Constant: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]* {
    if (is_keyword(yytext)) {
        printf("Keyword: %s\n", yytext);
    } else {
        printf("Identifier: %s\n", yytext);
    }
}
[+\-*/=<>!&|]+   { printf("Operator: %s\n", yytext); }
[{}()\[\],;]     { printf("Punctuation: %s\n", yytext); }
[^a-zA-Z0-9_ \t\r\n{}()\[\],;+\-*/=<>!&|] { 
    printf("Lexical Error: %s\n", yytext);
}
%%

int main() {
    printf("Enter C code:\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
