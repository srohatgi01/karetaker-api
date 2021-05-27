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

<br><br><br>his is just a practice paragraph text to demonstrate how paragraph works.
So now we have to add a line break. <br>
This is how you do it
<br>
<br>
This is a **bold** text
<br>
This is a *italic* text
<br>
This is ***bold-italic*** text
<br>
> This is some quote lol
>
> # This is some Heading quote lol.
>
> ## This is subheading quote lolol.
<br>

## Now time for some Ordered lists
1. This is the first list item in ordered list
2. This is second item in ordered list

## Now let's talk about Un-Ordered lists
- This is an unordered list
    - This is nested unordered list
        - This nested-nested unorderd list

## Noice, Let's type some code now!
`some code`
```
#include <stdio.h>

using namespace std;

int main() {
    printf("Hello World");

    return 0;
}
```