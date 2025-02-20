%{
#include <stdio.h>
#include <string.h>

int lowercase = 0, uppercase = 0, digit = 0, symbol = 0, length = 0;
%}

%%
[a-z]    { lowercase = 1; length++; }
[A-Z]    { uppercase = 1; length++; }
[0-9]    { digit = 1; length++; }
[*;#$@]  { symbol = 1; length++; }
.        { length++; }  /* Count any other character */
\n       { 
    if (length >= 9 && length <= 15 && lowercase && uppercase && digit && symbol) {
        printf("Valid password\n");
    } else {
        printf("Invalid password\n");
    }
    /* Reset counters for next input */
    lowercase = uppercase = digit = symbol = length = 0;
}
%%

int main() {
    printf("Enter password: ");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}