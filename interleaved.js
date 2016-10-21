'use strict';

const NumberConverter = require("number-converter").NumberConverter;

const int2bin = new NumberConverter(NumberConverter.DECIMAL, NumberConverter.BINARY);
//
// function interleaved(A, B, C) {
//   if (A === '' && B === '' && C === '') {
//     return true;
//   }
//   if (C === '') {
//     return false;
//   }
//
//   return ((C == A) && interleaved(A.substring(1), B, C.substring(1)))
//            || ((C == B) && interleaved(A, B.substring(1), C.substring(1)));
// }

function i2(A, B, C) {
  // Find lengths of the two strings
    let M = A.length, N = B.length;

    // Let us create a 2D table to store solutions of
    // subproblems.  C[i][j] will be true if C[0..i+j-1]
    // is an interleaving of A[0..i-1] and B[0..j-1].
    let IL = new Array(M+1);
for (let i = 0; i < M + 1; i++) {
  IL[i] = new Array(N+1);
}

for (let a = 0; a < M + 1; a++) {
  for (let b = 0; b < N + 1; b++) {
    IL[a][b] = false;
  }
}

    // C can be an interleaving of A and B only of sum
    // of lengths of A & B is equal to length of C.
    if ((M+N) != C.length)
       return false;

    // Process all characters of A and B
    for (let i=0; i<=M; ++i)
    {
        for (let j=0; j<=N; ++j)
        {
            // two empty strings have an empty string
            // as interleaving
            if (i==0 && j==0)
                IL[i][j] = true;

            // A is empty
            else if (i==0 && B[j-1]==C[j-1])
                IL[i][j] = IL[i][j-1];

            // B is empty
            else if (j==0 && A[i-1]==C[i-1])
                IL[i][j] = IL[i-1][j];

            // Current character of C matches with current character of A,
            // but doesn't match with current character of B
            else if(A[i-1]==C[i+j-1] && B[j-1]!=C[i+j-1])
                IL[i][j] = IL[i-1][j];

            // Current character of C matches with current character of B,
            // but doesn't match with current character of A
            else if (A[i-1]!=C[i+j-1] && B[j-1]==C[i+j-1])
                IL[i][j] = IL[i][j-1];

            // Current character of C matches with that of both A and B
            else if (A[i-1]==C[i+j-1] && B[j-1]==C[i+j-1])
                IL[i][j]=(IL[i-1][j] || IL[i][j-1]) ;
        }
    }

    return IL[M][N];
}

let a = int2bin.convert(22);
let b = int2bin.convert(25);
let c = int2bin.convert(698);

console.log(i2(a, b, c));
