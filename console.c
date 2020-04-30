#include <console.h>
#include <io.h>

short *vram = (void *) 0xb8000;
int cur;

void print(const char *s)
{
  int hi, lo;
  outb(0x3d4, 0xe);
  hi = inb(0x3d5);
  outb(0x3d4, 0xf);
  lo = inb(0x3d5);
  cur = (hi << 8) | lo;

  for (; *s; s++) {
    if (*s == '\n') {
      cur += 80 - cur % 80;
      continue;
    }
    vram[cur] = *s + 0xf00;
    cur++;
  }

  outb(0x3d4, 0xe);
  outb(0x3d5, cur >> 8);
  outb(0x3d4, 0xf);
  outb(0x3d5, cur & 0xff);
}
