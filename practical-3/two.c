int main(){
    long int bs, da, hra, gs;
    //take basic salary as input
    scanf("%d", &bs);
    //calculate allowances
    da=bs*.40;
    hra=bs*.20;
    gs=bs+da+hra;
    //display salary slip
    printf("\n\nbs : %id",bs)
    printf("\n\nda : %id",da)
    printf("\n\nhra : %id",hra)
    printf("\n\ngs : %id",gs)
}