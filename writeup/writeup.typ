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



== Introduction and Background
=== Program Overview
=== Circuit Creation
=== Verilog Generation
=== Binary Minimilization

== Contributions
_intentionally left blank_\
_open source contributions_

== Challenges

== Deliverables

== Setup and Results

_A complete list of dependencies can be found in this document's appendix section and within the readme found within the source code._\
All of my code was written on "Fedora Linux 41" and _should_ work on any unix like machine capable of running the required dependencies. 
And although it has not been tested, everything should be cross platform but may require a different setup to run, any common linux distrobution is recommended. \  
Some version of python3 is required, I am using version $3.13.9$ at the time my generation script was written. I originally developed my "circuit.c" program using the drop-in c compiler in zig but switched my makefile to use gcc for ease of use; at the time of writing my program I am using version $14.3.1$ of gcc. 

== Appendix


== References

