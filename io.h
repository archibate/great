#pragma once

static inline unsigned char inb(short port)
{
  unsigned char data;
  asm volatile ("in %%dx, %%al\n" : "=a" (data) : "d" (port));
  return data;
}

static inline void outb(short port, unsigned char data)
{
  asm volatile ("out %%al, %%dx\n" :: "a" (data), "d" (port));
}
