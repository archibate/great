MB_MAGIC equ 0x1badb002
MB_FLAGS equ 0

dd MB_MAGIC
dd MB_FLAGS
dd -(MB_MAGIC + MB_FLAGS)

global _start
_start:
  mov ax, 'O' + 0xf00
  mov [0xb8000], ax
  mov ax, 'K' + 0xf00
  mov [0xb8002], ax

  hlt
  jmp $-1
