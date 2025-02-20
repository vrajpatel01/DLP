%{
#include <stdio.h>

int char_count = 0, word_count = 0, line_count = 0;
%}

%%

\n          { line_count++; char_count++; }  // Count lines and newlines as characters
[ \t]+      { char_count++; }  // Count spaces and tabs as characters
.           { char_count++; }  // Count all other characters
[A-Za-z0-9]+ { word_count++; } // Count words (alphanumeric sequences)

%%

int main() {
    yylex();  // Start lexical analysis

    printf("Characters : %d\n", char_count);
    printf("Words : %d\n", word_count);
    printf("Lines : %d\n", line_count);

    return 0;
}

int yywrap() {
    return 1;
}