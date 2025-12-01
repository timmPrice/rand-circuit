from dataclasses import dataclass 
from typing import List, Tuple

@dataclass
class Circuit:
    n: int 
    m: int 
    p: int
    io: list [Tuple[str, str]]

def read_pla() -> Circuit: 
    with open("./out/reduced_circuit.pla", "r") as file:
        lines = file.readlines()

    n = int(lines[0].split()[1])
    m = int(lines[1].split()[1])
    p = int(lines[2].split()[1])

    io = []
    for line in lines[3:]: 
        cur = line.split()
        if len(cur) < 2:
            continue 
        input = cur[0]
        output = cur[1]
        io.append((input, output))
    c = Circuit(n, m, p, io)
    return c

def gen_verilog(circuit: Circuit):
    with open("./out/circuit.v", "w") as file:
        print("module circuit (", file=file)
        print(f"    input wire  [{circuit.n - 1}:0] in,", file=file)
        print(f"    output wire [{circuit.m - 1}:0] out", file=file)
        print(");", file=file)
        print("", file=file)
        for i in range(circuit.n):
            print(f"  wire x{i} = in[{i}];", file=file) 
        print("", file=file)
        for i in range(circuit.p):
            input, output = circuit.io[i] 
            input = input[::-1]
            if input == "-" * circuit.n:
                break
            else:
                conds = []
                print(f"  wire r{i} = ", end="", file=file)
                for j in range(circuit.n): 
                    if input[j] == "0":
                        conds.append(f"(x{j} == 0)")
                    elif input[j] == "1":
                        conds.append(f"(x{j} == 1)")
                    else:
                        continue
                for j in range(len(conds)):
                    print(f"{conds[j]}", end="", file=file)
                    if j != len(conds) - 1:
                        print(" && ", end="", file=file)
                print(f";", file=file)
        print("", file=file)
        for i in range(circuit.m):
            print(f"  assign out[{i}] = ", end="", file=file)
            for j in range(circuit.n):
                if circuit.io[j] == 1:
                print(f"", file=file)
            print(f";", file=file)
        print("", file=file)
        print("endmodule", file=file)

def main():
    circuit = read_pla()
    gen_verilog(circuit)
    print(circuit)
    return 0

if __name__ == "__main__":
    main()
