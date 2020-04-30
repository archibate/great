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
  call setup_gdt
  call _main
  hlt
  jmp $-1

setup_gdt:
  lgdt [gdtr]
  mov eax, 16
  mov ss, eax
  mov ds, eax
  mov es, eax
  mov fs, eax
  mov gs, eax
  pop eax
  push dword 8
  push eax
  retf

%macro segdesc 3
  dw (((%3) >> 12) & 0xffff), ((%2) & 0xffff)
  db (((%2) >> 16) & 0xff), (0x90 | (%1))
  db (0xc0 | (((%3) >> 28) & 0xf)), (((%2) >> 24) & 0xff)
%endmacro

  align 8
gdt:
  dd 0, 0
  segdesc 0xa, 0, 0xffffffff  ; 4GB, Code, R/X, Kernel
  segdesc 0x2, 0, 0xffffffff  ; 4GB, Data, R/W, Kernel

gdtr:
  dw $ - gdt - 1
  dd gdt

section .bss
	resb 8192
stack_top:
