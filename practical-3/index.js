import fs from 'fs';

const predefineOperators = new Set(["+", "-", "*", "/", "="]);
const predefineKeywords = new Set(["int", "float", "char", "double", "void", "if", "else", "for", "while", "do", "switch", "case", "break", "continue", "return"]);
const predefinePunctuations = new Set([";", ":", "{", "}", "(", ")", "[", "]", ",", "'"]);

const tokens = { keywords: [], operators: [], identifiers: [], punctuations: [], constants: [], strings: [], lexicalErrors: [] };
const symbolTable = new Set();

const read = fs.readFileSync('main.c', 'utf8');

const cleanedCode = read.replace(/\/\*.*?\*\//gs, '').replace(/\/\/.*$/gm, '');
// const words = cleanedCode.match(/\w+|\S/g) || [];
// const words = cleanedCode.match(/(?<!')\b\w+\b(?!')/g) || [];
// const words = cleanedCode.match(/'\w+'|\b\w+\b/g) || [];
// const words = cleanedCode.match(/''\w+'|\b\w+\b|[+\-*/=<>!&|%^~.,;:(){}\[\]<>?^]/g) || [];
const words = cleanedCode.match(/'[^']*'|\b\w+\b|[+\-*/=<>!&|%^~.,;:(){}\[\]<>?^]/g) || [];

words.forEach((token, index) => {
    if (predefineOperators.has(token)) {
        tokens.operators.push(token);
    } else if (predefineKeywords.has(token)) {
        tokens.keywords.push(token);
    } else if (predefinePunctuations.has(token)) {
        tokens.punctuations.push(token);
    } else if (/^\d+$/.test(token)) {
        tokens.constants.push(token);
    } else if (/^\d+[a-zA-Z]+$/.test(token)) {
        tokens.lexicalErrors.push(`${token} invalid lexeme`);
    } else if (/^'.*'$/.test(token)) {
        tokens.strings.push(token.slice(1, -1));
    } else if (/^".*"$/.test(token)) {
        tokens.strings.push(token.slice(1, -1));
    } else if (/^[a-zA-Z_][a-zA-Z0-9_]*$/.test(token)) {
        if (!predefinePunctuations.has(words[index + 1])) {
            symbolTable.add(token);
        }
        tokens.identifiers.push(token);
    } else {
        tokens.lexicalErrors.push(`${token} invalid lexeme`);
    }
});

console.log("TOKENS", tokens);
console.log("\nLEXICAL ERRORS", tokens.lexicalErrors);
console.log("\nSYMBOL TABLE ENTRIES");
Array.from(symbolTable).forEach((symbol, index) => console.log(`${index + 1}) ${symbol}`));