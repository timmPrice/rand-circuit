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

== § Introduction and Background
#set par(first-line-indent: 1em);
    Verilog is a Hardware Description Language which is used to describe the logical behavior of digital circuits.
    Modules within Verilog define componets or whole circuits, and the goal of this project is to automate the creation of random Verilog modules.

    Each Module created has a common anatomy of gates and wires. 
    Foundational digital logic is created using some combination of the following gates:
    AND, OR, NAND, NOR, and XOR.
    Given some number of inputs $n$ and some number of outputs $m$, there is some number $bold(X)$ for which 
    #line(length: 4cm, stroke: 0.2pt)
    $X in {[n+m], [n+m] + 1, ..., [alpha(n+m)]})$  
    
    where $alpha = 2$ but could be changed to represent a higher number of internal gates.

    From this program steps can be taken to create large datasets of verilog modules.


=== Program Overview
=== Circuit Creation
=== Verilog Generation
=== Binary Minimilization

== Contributions
_intentionally left blank_\
_open source contributions_

== Challenges

== Deliverables

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
_other versions may potentially work, but have not been tested_.


== References
