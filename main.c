int _main(void)
{
	short *vram = (void *) 0xb8000;

	vram[0] = 'O' + 0xf00;
	vram[1] = 'K' + 0xf00;
}
