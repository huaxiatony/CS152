%{
	int currLine = 1, currPos =1;
	int Integers = 0;
	int Operators = 0;
	int Parens = 0;
	int Equals = 0;
%}

DIGIT [0-9]

%%
"-"			{printf("MINUS\n"); currPos += yyleng;Operators++;}
"+"			{printf("PLUS\n"); currPos += yyleng;Operators++;}
"*"			{printf("MULT\n");currPos += yyleng;Operators++;}
"/"			{printf("DIV\n");currPos += yyleng;Operators++;}
"="			{printf("EQUAL\n");currPos += yyleng;Equals++;}
"("			{printf("L_PAREN\n");currPos += yyleng;Parens++;}
")"			{printf("R_PAREN\n");currPos += yyleng;Parens++;}
{DIGIT}+	{printf("NUMBER %s\n",yytext); currPos += yyleng;Integers++;}
[ \t]+ 		{currPos += yyleng;}
"\n"		{currLine++; currPos = 1;}
.			{printf("Error at line %d, column %d: unrecongnized symbol\"%s\"\n", currLine, currPos, yytext); exit(0);}
%%

int main(int argc, char ** argv)
{
	if(argc >= 2)
	{
		yyin = fopen(argv[1], "r");
		if(yyin == NULL)
		{
			yyin = stdin;
		}
	}
	else
	{
		yyin = stdin;
	}
	yylex();
	
	printf("\n");
	printf("Numbers of Integers %d\n" , Integers);
	printf("Numbers of Operators %d\n" , Operators);
	printf("Numbers of Parentheses %d\n" , Parens);
	printf("Numbers of Signs %d\n" , Equals);
}
