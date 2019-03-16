test: a.out
	./a.out

a.out: testbench.v clk_div.v hex_to_seg.v hex_display.v uart_in.v uart_out.v custome_clk_div.v uart_queue.v button_bounce.v posedge_impulse.v hex_to_ascii.v parity_check.v
	iverilog $^ -o $@

clean:
	rm -f a.out

help:
	@echo "  test  - Run testbench"
	@echo "  clean - Remove most generated files"
	@echo "  help  - Display this text"

.PHONY: clean test help
