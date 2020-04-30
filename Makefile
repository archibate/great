.PHONY: all
all: run

%.asm.o: %.asm
	nasm -felf -o $@ $<

%.c.o: %.c
	gcc -m32 -nostdinc -ffreestanding -fno-stack-protector -c -o $@ $<

kernel.elf: start.asm.o main.c.o
	ld -m elf_i386 -e _start -Ttext 0x100000 -o $@ $^

.PHONY: run
run: kernel.elf
	qemu-system-x86_64 -kernel $<

.SUFFIXES:
