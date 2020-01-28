
main:
	gprbuild -j0 -P adarrose.gpr

flash: main
	arm-eabi-objcopy -O binary main main.bin
	st-flash write $<.bin 0x08000000

.PHONY: flash
