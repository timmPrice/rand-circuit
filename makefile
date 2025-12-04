all: setup espresso circuit verilog

setup: out
	
out: 
	mkdir -p out

espresso: build/done

build/done: ./espresso/CMakeLists.txt
	@echo -e "\033[34m╔═════════════════════════════════════════════════╗\033[0m"
	@echo -e "\033[34m║                Building Espresso                ║\033[0m"
	@echo -e "\033[34m╚═════════════════════════════════════════════════╝\033[0m"
	@cmake -S ./espresso/ -B build
	@cmake --build build
	@touch build/done
	@echo -e "\033[34m╔═════════════════════════════════════════════════╗\033[0m"
	@echo -e "\033[34m║             Espresso Build Complete             ║\033[0m"
	@echo -e "\033[34m╚═════════════════════════════════════════════════╝\033[0m"

circuit: espresso circuit.c 
	@echo -e "\033[34m╔═════════════════════════════════════════════════╗\033[0m"
	@echo -e "\033[34m║                Building Circuit                 ║\033[0m"
	@echo -e "\033[34m╚═════════════════════════════════════════════════╝\033[0m"
	@echo -e "[0%]\033[36m  Building circuit.c \033[0m"
	@gcc circuit.c -o gencircuit
	@echo -e "[33%]\033[36m generating circuit \033[0m"
	@./gencircuit
	@echo -e "[66%]\033[36m reducing circuit \033[0m"
	@./build/espresso circuit.pla > ./out/reduced_circuit.pla
	@echo -e "[100%]\033[36m done. \033[0m"
	@echo -e "\033[34m╔═════════════════════════════════════════════════╗\033[0m"
	@echo -e "\033[34m║           Circuit Generation Complete           ║\033[0m"
	@echo -e "\033[34m╚═════════════════════════════════════════════════╝\033[0m"

verilog: gen_verilog.py
	@python3 gen_verilog.py
	@echo -e "\033[33m╔═════════════════════════════════════════════════╗\033[0m"
	@echo -e "\033[33m║          ~Verilog Generation Complete~          ║\033[0m"
	@echo -e "\033[33m╚═════════════════════════════════════════════════╝\033[0m"
clean: 
	@rm -rf ./build/
	@rm -f gencircuit
	@rm -f *.pla
	@rm -f *.out
	@rm -f ./out/*
	@echo -e "\033[31mcleaned\033[0m"

