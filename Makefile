.PHONY: all
all: run

%.asm.o: %.asm
	nasm -felf -o $@ $<

kernel.elf: start.asm.o
	ld -m elf_i386 -e _start -Ttext 0x100000 -o $@ $^

.PHONY: run
run: kernel.elf
	qemu-system-x86_64 -kernel $<

.SUFFIXES:
