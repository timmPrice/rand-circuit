#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

enum gateName {
    INPUT,
    OUTPUT,
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

int numInternal(int n, int m, int alpha, int* internal) {
    int int_nodes = floor(n + m) + rand() % (alpha * (n + m));
    *internal = int_nodes;
    return (n + m + int_nodes);
}

/* Generate n input nodes, m output nodes, and internal gate nodes */
Node* genNodes(int n, int m, int internal, int total_nodes) {
    
    Node* gateList = (Node*)malloc(total_nodes * sizeof(Node));

    if (gateList == NULL) {
        return NULL; 
    }

    for (int i = 0; i < total_nodes; i++) {
        if (i < n) { 
            /* generate n input nodes */
            Node input_temp = {INPUT, i, {-1, false}, {-1, false}};
            gateList[i] = input_temp;
        } else if (i < n + internal) {
            /* generate internal nodes */
            Node temp_node = {(enum gateName) (rand() % 6 + 2), i, {0, false}, {0, false}};
            gateList[i] = temp_node;
        } else {
            /* generate output nodes */ 
            Node output_temp = {OUTPUT, i, {-1, false}, {-1, false}};
            gateList[i] = output_temp;
        };
    }   

    return gateList;
}

void connect_nodes() {
    
}

int main () {
    srand(time(NULL));
    int n = 3; int m = 3;
    int internal = 0;
    int total_nodes = numInternal(n, m, 2, &internal);
    Node* nodes = genNodes(n, m, internal, total_nodes);

    for (int i = 0; i < total_nodes; i++) {
        printf("gateType: %u, inputA: %i, inputB: %i, gateId: %i\n", nodes[i].name, nodes[i].inputA.outputid, nodes[i].inputB.outputid, nodes[i].nodeid);
    }

    return 0; 
}
