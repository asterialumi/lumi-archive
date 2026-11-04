#include <stdio.h>
#include <math.h>

int deciBinIter(int n) {
    int rem, bin = 0, base = 1;
    do{
        bin += (n % 2) * base;
        base *= 10;
        n /= 2;
    }while(n > 0);

    return bin;
}

int deciBinRec(int n) {
    if(n == 0) {
        return n;
    } else{
        return (n % 10) + (deciBinRec(n / 10) * 2); //% and / is the base it wants to convert, * is the base it came from
    }
}

int baseConvertRec(int n, int base_to, int base_from) {
    if(n == 0) {
        return n;
    } else{
        return (n % base_to) + (deciBinRec(n / base_to) * base_from); //% and / is the base it wants to convert, * is the base it came from
    }
}


int main() {

    int n = 1101;
    printf("result: %d", deciBinRec(n));
}