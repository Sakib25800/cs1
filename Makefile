DEV=/dev/tty.usbserial-AQ01KE2B

FORCE:

%.hex: FORCE
	@echo Making $@
	avr-as -g -mmcu=atmega328p -o $*.o $*.s
	avr-ld -o $*.elf $*.o
	avr-objcopy -O ihex -R .eeprom $*.elf $@
	avrdude -c arduino -p atmega328p -P $(DEV) -b 115200 -D -U flash:w:$@:i

program: %.hex
	@echo Programming $<
	@make clean

clean:
	-rm -f *.hex
	-rm -f *.o
	-rm -f *.elf
