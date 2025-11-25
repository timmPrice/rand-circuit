all: setup espresso circuit

setup: out
	
out: 
	mkdir -p out

espresso: build/done

build/done: ./espresso/CMakeLists.txt
	cmake -S ./espresso/ -B build
	cmake --build build
	@touch build/done
	@echo -e "\033[34m╔═════════════════════════════════════════════════╗\033[0m"
	@echo -e "\033[34m║             Espresso Build Complete             ║\033[0m"
	@echo -e "\033[34m╚═════════════════════════════════════════════════╝\033[0m"

circuit: espresso circuit.c 
	zig cc circuit.c -o gencircuit
	@./gencircuit
	@./build/espresso circuit.pla > ./out/a.pla
	@echo -e "\033[34m╔═════════════════════════════════════════════════╗\033[0m"
	@echo -e "\033[34m║             Circuit Gen Complete                ║\033[0m"
	@echo -e "\033[34m╚═════════════════════════════════════════════════╝\033[0m"

clean: 
	rm -rf ./build/
	rm -f gencircuit
	rm -f *.pla
	rm -f *.out

