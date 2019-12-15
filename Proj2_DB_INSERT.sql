BULK INSERT titles 
FROM 'C:\TextFiles\titles.txt' 
WITH (
               CODEPAGE=1252,                  

		DATAFILETYPE = 'char',

		FIELDTERMINATOR = '\t',

		KEEPNULLS,

		ROWTERMINATOR = '\n'	            

	 )



BULK INSERT suppliers 
FROM 'C:\TextFiles\suppliers.txt' 
WITH (  

               CODEPAGE=1252,               

		DATAFILETYPE = 'char',

		FIELDTERMINATOR = '\t',

		KEEPNULLS,

		ROWTERMINATOR = '\n'	            

	  )


BULK INSERT shippers 
FROM 'C:\TextFiles\shippers.txt' 
WITH (

               CODEPAGE=1252,            

		DATAFILETYPE = 'char',

		FIELDTERMINATOR = '\t',

		KEEPNULLS,

		ROWTERMINATOR = '\n'	            

	  )



BULK INSERT customers 
FROM 'C:\TextFiles\customers.txt' 
WITH (

               CODEPAGE=1252,            

		DATAFILETYPE = 'char',

		FIELDTERMINATOR = '\t',

		KEEPNULLS,

		ROWTERMINATOR = '\n'	            
	  )



BULK INSERT products 
FROM 'C:\TextFiles\products.txt' 
WITH (
               CODEPAGE=1252,             

		DATAFILETYPE = 'char',

		FIELDTERMINATOR = '\t',

		KEEPNULLS,

		ROWTERMINATOR = '\n'	            

	  )



BULK INSERT order_details 
FROM 'C:\TextFiles\order_details.txt'  
WITH (

               CODEPAGE=1252,              

		DATAFILETYPE = 'char',

		FIELDTERMINATOR = '\t',

		KEEPNULLS,

		ROWTERMINATOR = '\n'	            

	  )



BULK INSERT orders 
FROM 'C:\TextFiles\orders.txt' 
WITH (

               CODEPAGE=1252,             

		DATAFILETYPE = 'char',

		FIELDTERMINATOR = '\t',

		KEEPNULLS,

		ROWTERMINATOR = '\n'	            

	  )

