/*What's the most expensive listing?  What else can you tell me about the listing?*/
SELECT 	
	*
FROM 
	sfo_listings
ORDER BY 
	price DESC
LIMIT 1;

/*What neighborhoods seem to be the most popular?*/
SELECT 
	*   /*neighborhood_group is null*/
FROM 
	sfo_listings
ORDER BY 
	availability_365 DESC;