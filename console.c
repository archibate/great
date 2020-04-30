#include <console.h>

short *vram = (void *) 0xb8000;
int cur;

void print(const char *s)
{
  for (; *s; s++) {
    if (*s == '\n') {
      cur += 80 - cur % 80;
      continue;
    }
    vram[cur] = *s + 0xf00;
    cur++;
  }
}
