%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"SafeLib.h"
#include<sys/time.h>

FILE *outFile_p;
FILE *outFile_p1;

extern FILE *yyin;
int counter=0;
int pointer[500];
int pointer2;
char *temp[500];
char *temp2;
int i=0;

extern "C" 
{

int yylex(void);
int yyparse(void);
void yyerror(const char* str)

{fprintf(stderr,"error: %s in line: %d please check your function arguments!\n*** NOW: if you are sure your code is correct, \n please insert// before your function call\nin orderto ignore this syntax error\n",str,counter+1); }

int yywrap()
{
return 1;
}
}

%}

%token CHAR 


%token STRCPY
%token STRCAT
%token BCOPY
%token MEMCPY
%token MEMCHR
%token MEMCCPY
%token MEMMOVE
%token MEMSET


%token SPRINTF
%token VSPRINTF
%token GETS
%token SCANF
%token GETOPT
%token STRECPY
%token STREADD
%token STRCCPY
%token STRTRNS
%token WCSCPY
%token WCSCAT


%token GETPASS
%token REALPATH


%token NEW
%token COM
%token TAB
%token EOL
%token SIMICOL
%token PERCENT



%union
{
int number;
char *string;
}

%token <string> LBRAK
%token <string> RBRAK
%token <string> ANY
%token <string> PLUS
%token <string> NUMBER
%token <string> MUL
%token <string> TCOM
%token <string> WORD
%token <string> LB
%token <string> RB
%token <string> WHITE

%left NUMBER

%%

commands: {fprintf(outFile_p,"%s","#include \"SafeLib.h\"\n");} /*empty*/
        | commands command
        ;
 
command : search1
        | search2
        | search3
        | search4
        ;
 
 search3: CHAR WORD{fprintf(outFile_p,"%s%s","char",$2);} 
        | CHAR WORD LB WORD
       {printf("pointer_before=%d",pointer);temp[i]=$2;
       printf("\ni=%d\n",i);
       if(!strcmp($4,"4"))
       {pointer[i]=1;printf("pointer=%d",pointer[i]);}
       else
       {pointer[i]=0;printf("pointer=%d",pointer[i]);}i++;
       fprintf(outFile_p,"%s%s%s%s","char",$2,$3,$4);
       printf("\ntemp=%s\n",temp[i-1]);}
       | CHAR WORD LB WORD SIMICOL search4
       {printf("pointer_before=%d",pointer);temp[i]=$2;
       printf("\ni=%d\n",i);
       if (!strcmp($4,"4"))
       {pointer[i]=1;printf("pointer=%d",pointer[i]);}
       else
       {pointer[i]=0;printf("pointer=%d",pointer[i]);}i++;
       fprintf(outFile_p,"%s%s%s%s","char",$2,$3,$4);
       printf("\ntemp=%s\n",temp[i-1]);}
       |
       NEW WORD
       {fprintf(outFile_p,"%s%s","new ",$2);}
       |
       NEW CHAR
       {fprintf(outFile_p,"%s%s","new ","char");}
       |
       NEW
       {fprintf(outFile_p,"new");} 
       |
       CHAR  
       {fprintf(outFile_p,"char");}
       |
       CHAR WORD LB RB
       {fprintf(outFile_p,"%s%s%s%s","char ",$2,$3,$4);}
       |
       WORD LB RB
       {fprintf(outFile_p,"%s%s%s",$1,$2,$3);}
       |
       WORD LB PLUS
       {fprintf(outFile_p,"%s%s%s",$1,$2,$3);}


search4:WORD LB WORD 
       {printf("pointer_before=%d",pointer);temp[i]=$1;
       printf("\ni=%d\n",i); 
       if (!strcmp($3,"4")) {pointer[i]=1;printf("pointer=%d",pointer[i]);}
       else {pointer[i]=0;printf("pointer=%d",pointer[i]);}i++;
       fprintf(outFile_p,"%s%s%s",$1,$2,$3);
       printf("\ntemp=%s\n",temp[i-1]);}  


search1:STRCPY LBRAK WORD SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~strcpy(",$3,",");
        fals=1;break;}k++;}if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_strcpy","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a strcpy() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}
        |
        STRCPY LBRAK WORD WHITE SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
	for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~strcpy(",$3,",");fals=1;break;}k++;}
        if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_strcpy","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a strcpy() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}
	|
	STRCPY LBRAK WORD RBRAK SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
	for(j=0;j<i;j++)
	{if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s%s","_~strcpy",$2,$3,"),");fals=1;break;}k++;}
        if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s%s","_strcpy",$2,"sizeof(",$3,")),",$3,",");
        fprintf(outFile_p1,"\nThere is a strcpy() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}
        |
	STRCPY LBRAK WORD WHITE RBRAK SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for (j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~strcpy(",$3,",");fals=1;break;}k++;}
        if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_strcpy","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a strcpy() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}   
        |
        STRCPY LBRAK WORD PLUS WORD SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s%s%s%s%s%s%s","~+~strcpy(","4","-",$5,",",$3,"+",$5,",");fals=1;break;}k++;}
        if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s%s%s%s%s%s","_strcpy",$2,"sizeof(",$3,")-",$5,",",$3,"+",$5,",");
        fprintf(outFile_p1,"\nThere is a strcpy() rewrite process in line %d\n",counter+1);}
	    |
        STRCPY             
        {fprintf(outFile_p,"%s","strcpy");}
        |
        STRCPY LBRAK
        {fprintf(outFile_p,"%s","strcpy");}
        |
        STRCAT LBRAK WORD SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~strcat(",$3,",");fals=1;break;}k++;}if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_strcat","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a strcat() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}
        |
        STRCAT LBRAK WORD WHITE SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for (j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~strcat(",$3,",");fals=1;break;}k++;}if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_strcat","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a strcat() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}                                     
        |
        STRCAT LBRAK WORD RBRAK SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
	for (j=0;j<i;j++)
	{if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s%s","_~strcat",$2,$3,"),");fals=1;break;}k++;}if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s%s","_strcat",$2,"sizeof(",$3,")),",$3,",");printf("\nfals=%d\n",fals);
        fprintf(outFile_p1,"\nThere is a strcat() rewrite process in line %d\n",counter+1);}
        |
        STRCAT LBRAK WORD WHITE RBRAK SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for (j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~strcat(",$3,",");fals=1;break;}k++;}if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_strcat","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a strcat() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}            
        |
        STRCAT LBRAK WORD PLUS WORD SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for (j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s%s%s%s%s%s%s","~+~strcat(","4","-",$5,",",$3,"+",$5,",");fals=1;break;}k++;}if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s%s%s%s%s%s","_strcat",$2,"sizeof(",$3,")-",$5,",",$3,"+",$5,",");
        fprintf(outFile_p1,"\nThere is a strcat() rewrite process in line %d\n",counter+1);}
	|
        STRCAT             
        {fprintf(outFile_p,"%s","strcat");}
        |
        STRCAT LBRAK
        {fprintf(outFile_p,"%s","strcat");}
        |
        BCOPY LBRAK WORD SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for (j=0;j<i;j++)
        {if (!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~bcopy(",$3,",");fals=1;break;}k++;}if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_bcopy","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a bcopy() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}
        |
        BCOPY LBRAK WORD PLUS WORD SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for (j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s%s%s%s%s%s%s%s","~+~bcopy","$2","4","-",$5,",",$3,"+",$5,",");fals=1;break;}k++;}
        if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s%s%s%s%s%s","_bcopy",$2,"sizeof(",$3,")-",$5,",",$3,"+",$5,",");
        fprintf(outFile_p1,"\nThere is a bcopy() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);} 	
        |
        BCOPY LBRAK WORD WHITE SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for (j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~bcopy(",$3,",");fals=1;break;}k++;}if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_bcopy","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a bcopy() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);} 
        |
        BCOPY
        {fprintf(outFile_p,"%s","_bcopy");}   
        |
        BCOPY LBRAK
        {fprintf(outFile_p,"%s%s","_bcopy",$2);}
        |
        BCOPY LBRAK ANY 
        {fprintf(outFile_p,"%s%s%s","_bcopy",$2,$3);}
        |     
        MEMCPY LBRAK WORD SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2)&& pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~memcpy(",$3,",");fals=1;break;}k++;}if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_memcpy","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a memcpy() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}
        |
        MEMCPY LBRAK WORD WHITE SIMICOL
        {int fals=0;temp2=$3,printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2)&& pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~memcpy(",$3,",");fals=1;break;}k++;}
        if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_memcpy","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a memcpy() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}
        |
        MEMCPY LBRAK WORD PLUS WORD SIMICOL
        {int fals=0;temp2=$3,printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2)&& pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s%s%s%s%s%s%s","~+~memcpy(","4","-",$5,",",$3,"+",$5,",");fals=1;break;}k++;}
        if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s%s%s%s%s%s","_memcpy",$2,"sizeof(",$3,")-",$5,",",$3,"+",$5,",");
        fprintf(outFile_p1,"\nThere is a memcpy() rewrite process in line %d\n",counter+1);}
        |
        MEMCHR LBRAK WORD SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2)&& pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~memchr(",$3,",");fals=1;break;}k++;}if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_memchr","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a memchr() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}
        |
        MEMCHR LBRAK WORD WHITE SIMICOL
        {int fals=0;temp2=$3,printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2)&& pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~memchr(",$3,",");fals=1;break;}k++;}
        if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_memchr","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a memchr() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}
        |
        MEMCHR LBRAK WORD PLUS WORD SIMICOL
        {int fals=0;temp2=$3,printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2)&& pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s%s%s%s%s%s%s","~+~memchr(","4","-",$5,",",$3,"+",$5,",");fals=1;break;}k++;}
        if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s%s%s%s%s%s","_memchr",$2,"sizeof(",$3,")-",$5,",",$3,"+",$5,",");
        fprintf(outFile_p1,"\nThere is a memchr() rewrite process in line %d\n",counter+1);}
        |   
        MEMCCPY LBRAK WORD SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2)&& pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~memccpy(",$3,",");fals=1;break;}k++;}if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_memccpy","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a memccpy() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}
        |
        MEMCCPY LBRAK WORD WHITE SIMICOL
        {int fals=0;temp2=$3,printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2)&& pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~memccpy(",$3,",");fals=1;break;}k++;}
        if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_memccpy","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a memccpy() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}
        |
        MEMMOVE LBRAK WORD SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2)&& pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~memmove(",$3,",");fals=1;break;}k++;}if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_memmove","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a memmove() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}
        |
        MEMMOVE LBRAK WORD WHITE SIMICOL
        {int fals=0;temp2=$3,printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2)&& pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~memmove(",$3,",");fals=1;break;}k++;}
        if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_memmove","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a memmove() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}
        |
        MEMSET LBRAK WORD SIMICOL
        {int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2)&& pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~memset(",$3,",");fals=1;break;}k++;}if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_memset","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a memset() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}
        |
        MEMSET LBRAK WORD WHITE SIMICOL
        {int fals=0;temp2=$3,printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2)&& pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s","_~memset(",$3,",");fals=1;break;}k++;}
        if(fals==0)
        fprintf(outFile_p,"%s%s%s%s%s%s","_memset","(sizeof(",$3,"),",$3,",");
        fprintf(outFile_p1,"\nThere is a memset() rewrite process in line %d\n",counter+1);
        printf("\nfals=%d\n",fals);}       
        |
        SPRINTF LBRAK WORD SIMICOL
        {int flipper1=0;int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for (j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s%s","/*warning: This function sprintf() has a buffer overflow security problem*/","sprintf(",$3,",");
        fprintf(outFile_p1,"\n High-Risk Warning::There is a sprintf() buffer overflow security problem in line %d::It is recommended to use snprintf() instead of sprintf()....\n snprintf is not exist in the standard library\n",counter+1);flipper1=1;fals=1;break;}
        if(!strcmp(temp[k],temp2))
        {fprintf(outFile_p,"%s%s%s%s","/*warning: This function sprintf() has a buffer overflow security problem*/","sprintf(",$3,",");
        fprintf(outFile_p1,"\n High-Risk Warning::There is a sprintf() buffer overflow security problem in line %d::It is recommended to use snprintf() instead of sprintf()....\n",counter+1);flipper1=1;break;}k++;}
        if(flipper1==0)fprintf(outFile_p,"%s%s%s","sprintf(",$3,",");}
        |
        SPRINTF
        {fprintf(outFile_p,"%s","sprintf");}
        |
        GETS LBRAK WORD RBRAK
        {int flipper1=0;int fals=0;temp2=$3;printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for (j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s%s","/*warning: This function gets() has a buffer overflow security problem*/","gets(",$3,")");
        fprintf(outFile_p1,"\n Very High-Risk Warning::There is a gets() buffer overflow security problem in line %d::It is recommended to use fgets() instead....\n",counter+1);flipper1=1;fals=1;break;}
        if(!strcmp(temp[k],temp2))
        {fprintf(outFile_p,"%s%s%s%s","/*warning: This function gets() has a buffer overflow security problem*/","gets(",$3,")");fprintf(outFile_p1,"\n Very High-Risk Warning::There is a gets() buffer overflow security problem in line %d::It is recommended to use fgets() instead....\n",counter+1);flipper1=1;break;}k++;}if(flipper1==0)
        fprintf(outFile_p,"%s%s%s","gets(",$3,")");}
        |
        VSPRINTF LBRAK WORD SIMICOL
        {int flipper1=0;int fals=0;temp2=$3;
        printf("\ntemp2=%s\n",temp2);int j=0;int k=0;
        for(j=0;j<i;j++)
        {if(!strcmp(temp[k],temp2) && pointer[k]==1)
        {fprintf(outFile_p,"%s%s%s%s","/*warning: This function vsprintf()has a buffer overflow security problem*/","vsprintf(",$3,",");
	fprintf(outFile_p1,"\n High-Risk Warning::There is a vsprintf() buffer overflow security problem in line %d::It is recommended to use vsnprintf() instead of vsprintf()....\n vsnprintf is not exist in the standard library\n",counter+1);flipper1=1;fals=1;break;}
        if(!strcmp(temp[k],temp2))
        {fprintf(outFile_p,"%s%s%s%s","/*warning: This function vsprintf() has a buffer overflow security problem*/","vsprintf(",$3,",");
	fprintf(outFile_p1,"\n High-Risk Warning::There is a vsprintf() buffer overflow security problem in line %d::It is recommended to use vsnprintf() instead of vsprintf()....\n",counter+1);flipper1=1;break;}k++;}
        if(flipper1==0)fprintf(outFile_p,"%s%s%s","vsprintf(",$3,",");}
        |       
        SCANF LBRAK TCOM PERCENT WORD
        {fprintf(outFile_p,"%s%s%s%s","\n/*There is a buffer overflow security problem using the following SCANF()*/\nscanf(","\"","%",$5);
	fprintf(outFile_p1,"\n High-Risk Warning::There is a scanf() buffer overflow security problem \n in line= %d,make sure that \%%s is given\n a defined value(i,e,\%%32s)\n",counter +1); 
	printf ("High-Risk Warning::There is a scanf() buffer overflow security problem in line=%d\n",counter+1);}
        |
        SCANF LBRAK TCOM PERCENT NUMBER
        {fprintf(outFile_p,"%s%s%s%s","scanf(","\"","%",$5);}
        |
        GETOPT LBRAK 
        {fprintf(outFile_p,"\n/*There is a buffer overflow security problem using the following GETOPT()*/\ngetopt()");
	fprintf(outFile_p1,"\n High-Risk Warning::There is a getopt() buffer overflow security problem in line %d\n",counter+1); 
        printf ("Warning:buffer overflow problem in line=%d\n",counter+1);}
	|
	GETPASS LBRAK
        {fprintf(outFile_p,"\n/*There is a buffer overflow security problem using the following GETPASS()*/\ngetpass()");
        fprintf(outFile_p1,"\n High-Risk Warning::There is a getpass() buffer overflow security problem in line %d\n",counter+1); 
        printf ("Warning:buffer overflow problem in line=%d\n",counter+1);}
        |        
        STRTRNS LBRAK
        {fprintf(outFile_p,"/*There is a buffer overflow security problem using the following STRTRNS()*/strtrns()");
        fprintf(outFile_p1,"\n Medium-Risk Warning::There is a buffer overflow security problem in line %d\n",counter+1); 
        printf ("Warning:buffer overflow problem in line=%d\n",counter+1);}       	        
        |
        REALPATH LBRAK 
        {fprintf(outFile_p,"\n/*Warning::There is buffer overflow security problem using the following REALPATH()*/\nrealpath()");
	fprintf(outFile_p1,"\n Medium-Risk Warning::There is a realpath() buffer overflow security problem in line %d\n",counter+1);
	printf("Warning:buffer overflow problem in line =%d\n",counter+1);}
        |
        STRECPY LBRAK 
        {fprintf(outFile_p,"\n/*Warning::There is buffer overflow security problem using the following STRECPY()*/\nstrecpy()");
	fprintf(outFile_p1,"\n Medium-Risk Warning::There is a strecpy() buffer overflow security problem in line %d\n",counter+1);
	printf("Warning:buffer overflow problem in line =%d\n",counter+1);}
        |
        STREADD LBRAK 
        {fprintf(outFile_p,"\n/*Warning::There is buffer overflow security problem using the following STREADD()*/\nstreadd()");
	fprintf(outFile_p1,"\n Medium-Risk Warning::There is a streadd() buffer overflow security problem in line %d\n",counter+1);
	printf("Warning:buffer overflow problem in line =%d\n",counter+1);}       
        |
        STRCCPY LBRAK 
        {fprintf(outFile_p,"\n/*Warning::There is buffer overflow security problem using the following STRCCPY()*/\nstrccpy()");
	fprintf(outFile_p1,"\n Medium-Risk Warning::There is a strccpy() buffer overflow security problem in line %d\n",counter+1);
	printf("Warning:buffer overflow problem in line =%d\n",counter+1);}
        |
        WCSCPY LBRAK 
        {fprintf(outFile_p,"\n/*Warning::There is buffer overflow security problem using the following WCSCPY()*/\nwcscpy()");
	fprintf(outFile_p1,"\n Medium-Risk Warning::There is a wcscpy() buffer overflow security problem in line %d\n",counter+1);
	printf("Warning:buffer overflow problem in line =%d\n",counter+1);}
        |
        WCSCAT LBRAK 
        {fprintf(outFile_p,"\n/*Warning::There is buffer overflow security problem using the following WCSCAT()*/\nwcscat()");
	fprintf(outFile_p1,"\n Medium-Risk Warning::There is a wcscat() buffer overflow security problem in line %d\n",counter+1);
	printf("Warning:buffer overflow problem in line =%d\n",counter+1);}





search2:WORD    {fprintf(outFile_p,$1);}
search2:WHITE   {fprintf(outFile_p,$1);}
       |TAB     {fprintf(outFile_p,"\t");}
       |EOL     {counter=counter+1;fprintf(outFile_p,"\n");}
       |LBRAK   {fprintf(outFile_p,$1);}
       |RBRAK   {fprintf(outFile_p,$1);}
       |SIMICOL {fprintf(outFile_p,",");}
       |PERCENT {fprintf(outFile_p,"%%");}
       |PLUS    {fprintf(outFile_p,"+");}
       |ANY     {fprintf(outFile_p,$1);}
       |TCOM    {fprintf(outFile_p,"\"");}
       |MUL     {fprintf(outFile_p,$1);}
       |COM     {fprintf(outFile_p,";");}
       |LB      {fprintf(outFile_p,"[");}
       |RB      {fprintf(outFile_p,"]");}
              
%%
     
     int main(int argc,char*argv[])  
     {
       
         int line_count = 0;
         FILE *fp;
         char ch;
         fp=fopen(argv[1],"r");
         while ((ch = fgetc(fp)) != EOF)
         {
         if (ch  ==  '\n')
         {
         line_count++;
         }
         }     
         
         if(argc<3)
         {
             printf("please specify the input and out file \n");
             exit(0);
             }
         
         fp=fopen(argv[1],"r");
          if(!fp)
             {
                 printf("couldn't open file for reading \n");
                 exit(0);
              }
         outFile_p=fopen(argv[2],"w");
         outFile_p1=fopen(argv[3],"w");
         if(!outFile_p)
             {
                 printf("couldn't open temp for writing outfile_p \n");
                 exit(0);
                 }
         if(!outFile_p1)
             {
                 printf("couldn't open temp for writing outfile_p1 \n");
                 exit(0);
                 }
        
    struct timeval tim; 
    gettimeofday(&tim, NULL);  
    double t1=tim.tv_sec+(tim.tv_usec/1000000.0);                   
    yyin=fp;
    yyparse();
    gettimeofday(&tim, NULL);  
    double t2=tim.tv_sec+(tim.tv_usec/1000000.0);
    double fsecs;  
    fclose(fp);
    fclose(outFile_p);
    fsecs=t2 - t1;
    printf("\n###########SCANNING ANALYSIS###################\n");
    printf("\nTOTAL LINES ANALYZED: %d\n", line_count);
    printf("\nTOTAL TIMES TO SCAN :%.6lf seconds\n", fsecs);
    printf("\nSCANNED LINES PER SECOND:%d\n", (int)(line_count/fsecs));
    printf("\n################################################\n");
    return 0;
  }
