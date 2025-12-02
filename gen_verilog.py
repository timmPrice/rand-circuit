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
        for i in range(circuit.p):
            input, output = circuit.io[i] 
            # input = input[::-1]
            if input == "-" * circuit.n:
                print(f"  wire r{i} = 1'b1;", file=file) 
                continue
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

        # output logic
        outs = [[] for _ in range(circuit.m)]
        for i, (input, output) in enumerate(circuit.io): 
            for bit in range(circuit.m):
                output = output[::-1]
                if output == "-" * circuit.m:
                    break
                elif output[bit] == "1":
                    outs[bit].append(f"r{i}")

        for i in range(circuit.m):
            ors = " | ".join(outs[i]) or "1'b0" 
            print(f"  assign out[{i}] = {ors};", file=file)
        print("", file=file)

        print("endmodule", file=file)

def gen_row(circuit: Circuit, file) -> list[str]: 
    conds: list[str] = []
    for i, (inp, outp) in enumerate(circuit.io):
        if inp == "-" * circuit.n:
            print(f"wire r{i} = 1'b1;")
            continue;
        else:
            for j in range(circuit.n):
                # print(f"  wire r{i} = ", end="", file=file)
                if inp[j] == "1":
                    conds.append(f"(x{j} == 1)")
                elif inp[j] == "0":
                    conds.append(f"(x{j} == 0)")

    return conds

def gen_assign(circuit: Circuit):
    print("")

def connect_row():
    print("")

def main():
    circuit = read_pla()
    # gen_verilog(circuit)
    return 0

if __name__ == "__main__":
    main()
