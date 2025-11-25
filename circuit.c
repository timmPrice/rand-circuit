#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "circuit.h"

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

bool evalNode(Node* nodes, int id, bool* inputs, bool* repeat, bool* repeatValid) {
    bool result;
    Node* g = &nodes[id];
    switch(g -> name) {
        case INPUT:
            result = inputs[id];
            break;

        case OUTPUT:
            result = evalNode(nodes, g -> inputA.outputid, inputs, repeat, repeatValid);
            break;

        default: {
            bool a = evalNode(nodes, g -> inputA.outputid, inputs, repeat, repeatValid);
            bool b = evalNode(nodes, g -> inputB.outputid, inputs, repeat, repeatValid);
            
            if (g -> inputA.not) {
                a = !a;
            }

            if (g -> inputB.not) {
                b = !b;
            }
           
            switch(g -> name) {
                case AND: 
                    result = a && b;
                    break;
                case OR: 
                    result = a || b;
                    break;
                case NAND: 
                    result = !(a && b);
                    break;
                case NOR: 
                    result = !(a || b);
                    break;
                case XOR: 
                    result = a ^ b;
                    break;
                default: 
                    result = 0;
            }
        }
    }
    repeat[id] = result;
    repeatValid[id] = true;
    return result;
}

void tableGen(Node* nodes, int n, int m, int internal) {
    bool repeat[1024];
    bool repeatValid[1024];
    bool inputs[32];

    int totalnodes = n + m + internal;

    FILE* fp = fopen("circuit.pla", "w");

    if (!fp) {
       perror("file does not exist");
       return;
    }
    
    fprintf(fp, ".i %d\n", n);
    fprintf(fp, ".o %d\n", m);

    for (int i = 0; i < (1 << n); i++) {
        for (int j = 0; j < n; j++) {
            inputs[j] = (i >> j) & 1;
        }

        for (int j = 0; j < totalnodes; j++)
            repeatValid[j] = false;

        // printf("input: ");
        for (int j = 0; j < n; j++) {
            fprintf(fp, "%d", inputs[j]); 
        }

        fprintf(fp, " ");

        // printf(" → output: ");
        for (int j = 0; j < m; j++) {
            bool val = evalNode(nodes, (n + internal + j), inputs, repeat, repeatValid);
            fprintf(fp, "%d", val);
        }
        fprintf(fp, "\n");
    }  
    fprintf(fp, ".e\n");
    fclose(fp);
}

int main() {
    srand(time(NULL));
    int n = 5; int m = 5;
    int internal = 0;
    int total_nodes = numInternal(n, m, 10, &internal);
    Node* nodes = genNodes(n, m, internal, total_nodes);

    // for (int i = 0; i < total_nodes; i++) {
    //     printf("gateType: %u, inputA: %i, inputB: %i, gateId: %i\n", nodes[i].name, nodes[i].inputA.outputid, nodes[i].inputB.outputid, nodes[i].nodeid);
    // }

    tableGen(nodes, n, m, internal);
    return 0; 
}
