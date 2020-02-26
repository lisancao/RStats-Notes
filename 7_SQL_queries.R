##############################################################

## USING SQL WITHIN R 
# ADAPTED FROM LLOYD ELLIOT COURSE MATERIALS 

##############################################################

# load libraries 
# these libraries will be required to set up the SQL connection 
library(RSQLite)
library(DBI)


#  set up connection and specify database filename in wd
db_data = dbConnect(SQLite(), dbname = "data.sqlite")

# list tables within the database connection
dbListTables(db_data)

# read a table into an r dataframe 
db_table <- dbReadTable(db_data, "table")

colnames(db_table) # you can now use regular r functions on the data 



###PRAGMA 
#use PRAGMA to return a data frame with one row for each column of the database table 
#notnull states if the column has any NULL values 
#dflt_value = default value if present 
query = "PRAGMA table_info('table')"

dbGetQuery(db_data, query)


###DISTINCT 
#analagous to unique() in SQL 
query2 = "SELECT DISTINCT * FROM table;" #not very useful
dbGetQuery(db_data, query2)


#How many distinct years are present among the medals listed in the table? 
colnames(dbReadTable(dbcon, "table"))
query3 = "SELECT DISTINCT year FROM table" #way more useful
nrow(dbGetQuery(db_data, query3))


### Return records in order 
#ORDER BY - sort the returned records by one or more columns 
#ORDER BY variable-name sorts the records in ascending order by default 
#DESC - sort in descending order 
#ORDER BY variablename DESC, or ORDER BY v1, v2 DESC 


#use an sql command to provide the unique set of distinct heights of pokemon from the height_m column of the pokem datable, in descending order. one height per line 
colnames(dbReadTable(db_data, "table"))

query4 = "SELECT DISTINCT Height_m FROM table ORDER BY colname DESC"

dbGetQuery(db_data, query4)

################
### you can send query without returning records using dbSendQuery 
queryout = dbSendQuery(dbcon, query4)

dbFetch(queryout, 5) # return limited number of queries 

dbClearResult(queryout) #clear result 


### INNER JOIN 
joinzip_query = "SELECT * FROM table1 INNER JOIN table2 ON table1.colname=table2.colname"
dbGetQuery(db_data, joinzip_query)

# examples with WHERE
sql_query2 = "SELECT * FROM CA INNER JOIN POP2011 ON CA.Geographic_name = POP2011.Geographic_name WHERE Total_private_dwellings__2011 == 0"

zipfine_query = "SELECT * FROM zip INNER JOIN tickets ON zip.zip_code=tickets.zip_code WHERE tickets.fine_level1_amount > 100"


### extracting information from text 
#building queries to pull data based on the appearance of text entries using %

dbGetQuery(dbcon, "SELECT * FROM table WHERE colname LIKE 'keyword%' ")

# example with "anywhere in" 

dbPARKING = dbGetQuery(dbcon, "SELECT * FROM tickets WHERE violation_description LIKE '%PARKING%' ")



