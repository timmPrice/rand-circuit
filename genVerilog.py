from dataclasses import dataclass 
from typing import List, Tuple

@dataclass
class Circuit:
    n: int | None
    m: int | None
    io: list [Tuple[str, str]]

def read_pla() -> Circuit: 
    with open("./out/reduced-circuit.pla", "r") as file:
        lines = file.readlines()

    n = int(lines[0].split()[1])
    m = int(lines[1].split()[1])

    io = []
    for line in lines[2:]: 
        cur = line.split()
        if len(cur) < 2:
            continue 
        input = cur[0]
        output = cur[1]
        io.append((input, output))
    c = Circuit(n, m, io)
    return c

def gen_verilog():
    print("")

def main():
    circuit = read_pla()
    return 0

if __name__ == "__main__":
    main()
