
main:
	gprbuild -j0 -P adarrose.gpr

flash: main
	st-flash write $< 0x08000000

.PHONY: flash
