#include <stdio.h>
#include <stdlib.h>
#include <time.h>

enum gateName{
    AND,
    OR,
    NAND,
    NOR,
    XOR,
    NOT,
};

typedef struct {
    enum gateName name;
    int nodeid;
    int inputA;
    int inputB;
} Node;

/* Generate internal gate nodes */
Node* genNodes(int n) {
    Node* gateList = (Node*)malloc(n * sizeof(Node));

    if (gateList == NULL) {
        return NULL; 
    }

    for (int i = 0; i < n; i++) {
        Node temp_node = {(enum gateName) (rand() % 6), i, 0, 0};
        gateList[i] = temp_node;
    }    

    return gateList;
}

int main () {
    srand(time(NULL));
    int n = 100;
    Node* nodes = genNodes(n);

    for (int i = 0; i < n; i++) {
        printf("gateType: %u, inputA: %i, inputB: %i, gateId: %i\n", nodes[i].name, nodes[i].inputA, nodes[i].inputB, nodes[i].nodeid);
    }

    return 0; 
}
