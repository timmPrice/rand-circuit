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

# generates verilog from reduced pla circuit
def gen_verilog(circuit: Circuit):
    with open("./out/circuit.v", "w") as file:
        print("module circuit (", file=file)
        print(f"    input wire  [{circuit.n - 1}:0] in,", file=file)
        print(f"    output wire [{circuit.m - 1}:0] out", file=file)
        print(");", file=file)
        print("", file=file)
       
        # gen input wires
        for i in range(circuit.n):
            print(f"  wire x{i} = in[{i}];", file=file) 
        print("", file=file)
      
        # row logic
        rows = gen_row(circuit, file)
        for i, bits in enumerate(rows):
            if bits == []:
                continue
            if bits:
                row = " && ".join(bits)
                print(f"  wire r{i} = {row};", file=file)
            else:
                print(f"  wire r{i} = 1'b1;", file=file)
        print("", file=file)

        # output logic
        rows = gen_assign(circuit)
        for i in range(circuit.m):
            a_row = " | ".join(rows[i]) or "1'b0" 
            print(f"  assign out[{i}] = {a_row};", file=file)
        print("", file=file)

        print("endmodule", file=file)

def gen_row(circuit: Circuit, file) -> list[list[str]]: 
    rows: list[list[str]] = []
    for i, (inp, _) in enumerate(circuit.io):
        if inp == "-" * circuit.n:
            print(f"wire r{i} = 1'b1;", file=file)
            continue;
        
        conds: list[str] = []
        for j in range(circuit.n):
            if inp[j] == "1":
                conds.append(f"(x{j} == 1)")
            elif inp[j] == "0":
                conds.append(f"(x{j} == 0)")
        rows.append(conds)
    return rows 

def gen_assign(circuit: Circuit) -> list[list[str]]:
    rows = [[] for _ in range(circuit.m)]
    for i, (_, outp) in enumerate(circuit.io):
        for bit in range(circuit.m):
            if outp[bit] == "1":
                rows[bit].append(f"r{i}")
    return rows

def connect_row():
    print("")

def main():
    circuit = read_pla()
    gen_verilog(circuit)
    return 0

if __name__ == "__main__":
    main()
