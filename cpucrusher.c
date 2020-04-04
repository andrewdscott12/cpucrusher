#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <math.h>
#include <time.h>

#define _USE_MATH_DEFINES

/* Small program to spawn threads and perform some math and character manipulation*/

//Input is long double representing the max value for the loop
//return is the value of a after loop completes

struct th {
	pthread_t thread;
	int id;
	int iterations;
	double ret;
};


void * myloop(void *id)
{
	double a;
	struct th *self = (struct th *) id;
	int i;
	int r = rand();

	printf("My thread id is %d\n", self->id);
	printf("Thread %d is executing\n", self->id);

	for ( i = 1; i <= self->iterations; i++ )
	{
		a = (sqrt( a + i ) / 11 ) * r;
	}
	self->ret = a;
}


int main(int argc, char *argv[])
{
	srand(time(NULL));
	int status = NULL;
	int threadNum;
	int i = 0; //index for our thread launching loop


	if ( argc != 3 ) /* exit with some help if no arguments */
	{
		printf( "usage: %s <numthreads> <loop iterations>\n", argv[0] );
		exit(0);
	}
	/* create some variables and populate them with the arguements */
	
	threadNum = atoi(argv[1]);
	struct th th[threadNum];
	for ( i = 0; i < threadNum; i++ ) {
		th[i].iterations = atoi(argv[2]);
	}
		
	for ( i = 0; i < threadNum; i++)
	{
		th[i].id = i;
		status=pthread_create(&th[i].thread,NULL,myloop,&th[i]);
		if(status) {
			printf("Error creating threads\n");
			exit(0);
		}	
	}
	for ( i = 0; i < threadNum; i++)
	{
		status = 0;
		status = pthread_join(th[i].thread, NULL);
		if(status) {
			printf("Error joining thread id %d\n", th[i].id);
		}
		printf("The value in result %d is %e\n", i, th[i].ret);
	}

}

