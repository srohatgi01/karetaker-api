
# Karetaker - Your Personal Healthcare Companion


## Routes

The below mentioned is the base url anyone will follow. All the routes will continue from this base url.<br>
```
    http://localhost:4000/api/v1
```


### User Route 

> This is the top-most users route. Everything regarding user's information will be executed from this top-most route.<br>

- This route will return all the **users** from the database. 

        GET http://localhost:4000/api/v1/users

- To get a specific user from **user_id** i.e **email_address**, you will go to this route and insert email address in place of **":id"**
    
        GET http://localhost:4000/api/v1/users/getuser/:id
    
- To create a new user you will go to this route

        POST http://localhost:4000/api/v1/users

    > To create a new user with minimum details, you will require, ***first_name, last_name & email_address***


<br>

### Search Route

> This is the route which should be used to find doctors in the search field

- This route will return all the **doctors** regarding the letters you input


        GET http://localhost:4000/api/v1/doctors/search/:search_characters
        

### Doctor Profile Route

> This is the route which should be used after using the search route to get all the details for the specific doctor using doctor's id.

- This route will return all the details of a specific doctor


        GET http://localhost:4000/api/v1/doctors/doctorbyid/:id
        

