test: a.out
	./a.out

a.out: testbench.v clk_div.v button_bounce.v uart_out.v posedge_impulse.v
	iverilog $^ -o $@

clean:
	rm -f a.out

help:
	@echo "  test  - Run testbench"
	@echo "  clean - Remove most generated files"
	@echo "  help  - Display this text"

.PHONY: clean test help
