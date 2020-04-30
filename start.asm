MB_MAGIC equ 0x1badb002
MB_FLAGS equ 0

dd MB_MAGIC
dd MB_FLAGS
dd -(MB_MAGIC + MB_FLAGS)

section .text
global _start
extern _main
_start:
	mov esp, stack_top
	call _main
  hlt
  jmp $-1

section .bss
	resb 8192
stack_top:
