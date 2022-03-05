



AVRDUDE_OPTS=-p m128rfa1
AVRDUDE_OPTS+=-P usb -c usbasp-clone


.PHONY: fuses
fuses: lock.txt efuse.txt hfuse.txt lfuse.txt
	for f in $^; do echo "$$f: $$(cat $$f)"; done

dump: flash-dump.hex eeprom-dump.hex calibration-dump.hex

%-dump.hex:
	avrdude $(AVRDUDE_OPTS) \
	    -U $*:r:$@:i


lock.txt efuse.txt hfuse.txt lfuse.txt:
	avrdude $(AVRDUDE_OPTS) \
	    -U lock:r:lock.txt:b \
	    -U efuse:r:efuse.txt:b \
	    -U hfuse:r:hfuse.txt:b \
	    -U lfuse:r:lfuse.txt:b
