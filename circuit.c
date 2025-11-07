#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

enum gateName {
    input,
    output,
    AND,
    OR,
    NAND,
    NOR,
    XOR,
};

typedef struct {
    int outputid; /* which node drives this input */
    bool not;
} InputEdge;

typedef struct {
    enum gateName name;
    int nodeid;
    InputEdge inputA;
    InputEdge inputB;
} Node;

/* Generate n input nodes, m output nodes, and internal gate nodes */
Node* genNodes(int n, int m, int* out_size, int alpha) {
    int internal = floor(n + m) + rand() % (alpha * (n + m));
    int total_nodes = n + m + internal;

    *out_size = total_nodes;

    Node* gateList = (Node*)malloc(total_nodes * sizeof(Node));

    if (gateList == NULL) {
        return NULL; 
    }

    for (int i = 0; i < total_nodes; i++) {
        if (i < n) { 
            /* generate n input nodes */
            Node input_temp = {input, i, {-1, false}, {-1, false}};
            gateList[i] = input_temp;
        } else if (i < n + internal) {
            /* generate internal nodes */
            Node temp_node = {(enum gateName) (rand() % 6 + 2), i, {0, false}, {0, false}};
            gateList[i] = temp_node;
        } else {
            /* generate output nodes */ 
            Node output_temp = {output, i, {-1, false}, {-1, false}};
            gateList[i] = output_temp;
        };
    }   

    return gateList;
}

void returnNodes() {

}

int main () {
    srand(time(NULL));
    int n = 3; int m = 3;
    int nodes_length = 0;
    Node* nodes = genNodes(n, m, &nodes_length, 2);

    for (int i = 0; i < nodes_length; i++) {
        printf("gateType: %u, inputA: %i, inputB: %i, gateId: %i\n", nodes[i].name, nodes[i].inputA.outputid, nodes[i].inputB.outputid, nodes[i].nodeid);
    }

    return 0; 
}
