#set page(columns: 2, numbering: "1 of 1" )
#place(
  top + center,
  scope: "parent",
  float: true,
  text(1.4em, weight: "bold")[
    Random Circuit Verilog Code Generation 
  ],
)

#place(
  top + center,
  scope: "parent",
  float: true,
  text(1.0em)[
    Tim Price - CSCI 4532
  ],
)

== § $dot$ Introduction and Background
=== 1.1 $dot$ Program Overview 
#set par(first-line-indent: 1em);
    Verilog is a Hardware Description Language which is used to describe the logical behavior of digital circuits.
    Modules within Verilog define componets or whole circuits, and the goal of this project is to automate the creation of random Verilog modules representing combinational logic circuits.

    Each Module created has a common anatomy of gates and wires.
    Foundational digital logic is created using some combination of the following gates:
    AND, OR, NAND, NOR, NOT and XOR. 
    Traditionally each gate can have any number of input and output wires refered to as the gate's fan-in and fan-out respectively.
    For this project all gates that are generated must have a limited fan-in of $2$ and can have an unlimited fan-out.
    This means that any gate must have exactly $2$-inputs but can be used to drive inputs for any number of other gates.
    
    To determine the number of internal gates used in the generated circuit, some number of inputs $n$ and some number of outputs $m$ are used to randomly select $bold(X)$ number of internal gates in the available range. 
    
    #figure(caption: "Internal Gate Range")[
        #line(length: 6cm, stroke: 0.2pt)
        $bold(X) in {[n+m], [n+m] + 1, ..., [alpha(n+m)]}$ 
         
        and $alpha = x in {RR}$.
        #line(length: 7cm, stroke: 0.2pt)
    ]
    After the total number of gates is selected, all $bold(X)$ gates are each randomly assigned a gate type (AND, OR, etc.).
    
    To connect internal nodes, a DAG graph data-structure is used. A #emph("DAG") or directed-acyclic-graph is where each edge or wire 
    has a directed path (can only go in a certain direction) and is acylic meaning there are no loops or cycles in the graph connections which could lead to sequential circuit behavior.

    The way to enforce this structure is by using Topological Sorting when assigning each gates inputs. When generating nodes each is put in a list in order of creation.

#figure()[
```c
// some code 

connect_internal_nodes(...) 
{   
  for(int i = n; i < internal + n; i++)
  {
    nodes[i].inputA.oid = rand() % i; 
    nodes[i].inputB.oid = rand() % i; 
    nodes[i].inputA.not = rand() % 2;
    nodes[i].inputB.not = rand() % 2;
  }
}

// some code 
```    
]
    Since the nodes are generated in an ordered list, this loops through each node starting at the first internal node
    and randomly selecting an internal node or input node that came before it in the list. Additionally, each inputs node's input wire may be inverted 
    to capture the behavior of the NOT gate; NOT's behavior works with single wires instead of requiring a whole gate.
    This allows any single node's output to be selected by any number of nodes that come after it in the list, fulfilling the unlimited fan-out requirement.
    To connect nodes to outputs, a random internal node is selected and connected to an output node. 
    This concludes the generation of the random circuit. 

    It is most likely that there is some redundency in the generated circuit.
    Not all output nodes are effected by its chain of logic or the preceding inputs.
    #figure(caption: "Redundant Logic Minimilization")[ 
        #line(length: 6cm, stroke: 0.2pt)
        $
            y = a dot b | a dot accent(b, hat) \
            y = a dot (b dot accent(b, hat)) \
            y = a
        $
        #line(length: 7cm, stroke: 0.2pt)
    ] 
    
    In Figure 2, the output $y$ is independent of its input $b$ and therefore can be removed from the circuit to reduce or minimize the number of gates and "work" being done by the circuit. 

 === 1.2 $dot$ Use Cases
#set par(first-line-indent: 1em);
    From this program steps can be taken to create large datasets of verilog modules.

== § $dot$ Contributions
_intentionally left blank_\
_open source contributions_

== § Challenges

== § Deliverables

== § Setup and Results

#strong[dependencies:]\
_this list contains depencies and the versions that were used whilst testing and developing_

#list(
    [gcc - 14.3.1],
    [python3 - 3.13.9],
    [make - 4.4.1],
    [GNU bash - 5.2.32],
    [hadipourh/espresso - 3.0 (included in src)],
    [steveicarus/iverilog - 11.0+ (optional)]
)
_other versions may work, but have not been tested_.


#set page(columns: 1)
#place(
  top + center,
  scope: "parent",
  float: true,
  text(1.2em, weight: "bold")[
    § $dot$ References 
  ]
) 

#list(
    spacing: 1.3em,
    marker: $dot$,
    [Wikipedia (12/1/2025). Directed Acyclic Graph. Wikipedia. #link("https://en.wikipedia.org/wiki/Directed_acyclic_graph")],
    [ Wikipedia (11/23/2025). Topological Sorting. Wikipedia. #link("https://en.wikipedia.org/wiki/Topological_sorting")] ,
)
