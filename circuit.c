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

/* connects internal and input nodes */
void connect_internal_nodes(int n, int internal, int total_nodes, Node* nodes) {
    /* internal gates range from n -> internal + n */
    for(int i = n; i < internal + n; i++) {
        nodes[i].inputA.outputid = rand() % i; 
        nodes[i].inputB.outputid = rand () % i; 

        nodes[i].inputA.not = rand() % 2;
        nodes[i].inputB.not = rand() % 2;
    }
}

void connect_output_nodes(int n, int m, int internal, int total_nodes, Node* nodes) {
    int output_range = n + internal;
    for(int i = output_range; i < output_range + m; i++) {
        nodes[i].inputA.outputid = (rand() % internal) + n;
        nodes[i].inputB.outputid = -1;  
    }
}

/* Generate n input nodes, m output nodes, and internal gate nodes and connect graph randomly */
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
            Node temp_node = {(enum gateName) (rand() % 5 + 2), i, {0, false}, {0, false}};
            gateList[i] = temp_node;
        } else {
            /* generate output nodes */ 
            Node output_temp = {OUTPUT, i, {-1, false}, {-1, false}};
            gateList[i] = output_temp;
        };
    }   
    
    connect_internal_nodes(n, internal, total_nodes, gateList);
    connect_output_nodes(n, m, internal, total_nodes, gateList);
    return gateList;
}

int main () {
    srand(time(NULL));
    int n = 5; int m = 5;
    int internal = 0;
    int total_nodes = numInternal(n, m, 2, &internal);
    Node* nodes = genNodes(n, m, internal, total_nodes);

    for (int i = 0; i < total_nodes; i++) {
        printf("gateType: %u, inputA: %i, inputB: %i, gateId: %i\n", nodes[i].name, nodes[i].inputA.outputid, nodes[i].inputB.outputid, nodes[i].nodeid);
        printf("nots: %b, %b\n", nodes[i].inputA.not, nodes[i].inputB.not);
    }

    return 0; 
}
