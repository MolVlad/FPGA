test: a.out
	./a.out

a.out: testbench.v hex_to_seg.v hex_display.v my_block.v const.v RET_TXD_CRC_BL.v URXD_CRC_BL.v
	iverilog $^ -o $@

clean:
	rm -f a.out

help:
	@echo "  test  - Run testbench"
	@echo "  clean - Remove most generated files"
	@echo "  help  - Display this text"

.PHONY: clean test help
