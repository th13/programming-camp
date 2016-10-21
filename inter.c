#include <stdio.h>

int is_interleaved(char *A, char *B, char *C)
{
    // Base Case: If all strings are empty
    if (!(*A || *B || *C))
        return 1;

    // If C is empty and any of the two strings is not empty
    if (*C == '\0')
        return 0;

    // If any of the above mentioned two possibilities is true,
    // then return true, otherwise false
    return ( (*C == *A) && is_interleaved(A+1, B, C+1))
           || ((*C == *B) && is_interleaved(A, B+1, C+1));
}

void bin(unsigned n, char* str)
{
  static int count = 0;
    /* step 1 */
    if (n > 1) {
      bin(n/2, str);
      count++;
    }

    /* step 2 */
    printf(str, "%d", n % 2);
    count = 0;
}

int main() {

  char* t1 = "10110";
  char* t2 = "11001";
  char* t3 = "1010111010";

  int a, b, c;

  scanf("%d %d %d", &a, &b, &c);

  char t[256];
  bin(1901, t);
  printf("%s\n", t);


  int ans = is_interleaved(t1, t2, t3);

  printf("%d\n", ans);

  return 0;
}
