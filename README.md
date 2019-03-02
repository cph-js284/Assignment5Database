# Assignment5Database
This is the 5th. assignment for PB. database soft2019spring

-----------------------------------------------------------------------------------------------------------------
# What is it.
This is a series of sql-scripts meant to be executed by either sourcing from the mysql-shell or copied directly into the mysql-shell

------------------------------------------------------------------------------------------------------------------------
# Setup

1) Clone the repo.
2) Start a docker container running Mysql
````
sudo docker run --name mysql01 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=test1234 -d mysql

````
3) Copy the folder containing the scripts into the container
````
sudo docker cp Assignment5scripts/ mysql01:/
````
4) Enter the container
```
sudo docker exec -it mysql01 bash 
```
5) Prepare the container for 7zip
```
apt-get update
```
6) Install 7zip in the container - this is needed to decompress the dataset
```
apt-get install wget p7zip-full -y
```
7) Download the dataset
```
wget https://archive.org/download/stackexchange/coffee.stackexchange.com.7z
```
8) Decompress the dataset
```
7z e coffee.stackexchange.com.7z 
```

*This takes care of the setup now for the actual data*

1) Enter the MySql-shell
```
mysql -u root -ptest1234  --local-infile
```
2) Setup populate the tables - using the setup-script from the assignment <br>
*(the only tweak I've made to this script is added a 'Comments' column to the posts table, this column is used in excercise 1, and changed the path to the XML-files)*
````
source ./Assignment5scripts/CreateTables.sql;
````

# Excercise 1
The script for this excercise is in the file *1sp_DenormalizeComments.sql*
```
source ./Assignment5scripts/1sp_DenormalizeComments.sql;
```
To use it
```
call denormalizeComments(<valid PostId>)
```
# Excercise 2
The script for this excercise is in the file *2tg_comments_after_insert.sql*<br>
*this trigger basicly just calls the stored procedure from excercise 1, with the id of whatever post got the added comment*
```
source ./Assignment5scripts/2tg_comments_after_insert.sql;
```
# Excercise 3
The script for this excercise is in the files *3asp_TransferCommentsToPost.sql and 3bsp_CreateNewCommetsAndPost.sql*
first disable the trigger from excercise 2
```
DROP TRIGGER IF EXISTS comments_AFTER_INSERT;
```
Then source the scripts
```
source ./Assignment5scripts/3asp_TransferCommentsToPost.sql;
source ./Assignment5scripts/3bsp_CreateNewCommetsAndPost.sql;
```
To use it 
```
call CreateNewCommentAndPost(<valid postid>, <comment you want to add>, <valid userid>)
```
# Excercise 4
The script for this excercise is in the files *4sp_CreateMatView.sql and 4tg_maintenance_matView.sql*
The stored procedure *CreateMatView*, creates the table the data is kept in; the file *4tg_maintenance_matView.sql* contains triggers that maintains the matView-table after *insert, update, delete*, these are used to secure data consistancy.
```
source ./Assignment5scripts/4sp_CreateMatView.sql;
source ./Assignment5scripts/4tg_maintenance_matView.sql;
```
# Excercise 5
The script for this excercise is in the file *5sp_MySearch.sql*<br>
This stored procedure returns the postid from the post inwhich the keyword was found, and the number of times the keyword was found in comments tied to the specific post.<br>
*I have opted not to show the actual body of the post in the result, this could easily be changed with a select '*' *
```
source ./Assignment5scripts/5sp_MySearch.sql;
```
To use it 
```
call MySearch(<search-term/keyword>)
```



--------------------------------------------------------------------------------------------------------------------
# Clean-up
You can delete the container with the follow command, aside from the repo itself, this will remove everything installed in this readme
```
sudo docker rm -f mysql01
```
