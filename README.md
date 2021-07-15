
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
        

### Health Stats Routes

> This is the route which should be used to get the readings of health stats.

- This route will return all the sugar readings for the given user


        GET http://localhost:4000/api/v1/users/sugar/sugarbyid/:id

        
- This route will return all the heart rate readings for the given user


        GET http://localhost:4000/api/v1/users/bloodpressure/bloodpressurebyid/:id


- This route will return all the blood pressure readings for the given user


        GET http://localhost:4000/api/v1/users/heart/heartbyid/:id

        
- This route will return the latest sugar reading of a particular user


        GET http://localhost:4000/api/v1/users/sugar/latest/:id

- This route will return the latest blood pressure reading of a particular user


        GET http://localhost:4000/api/v1/users/bloodpressure/latest/:id

- This route will return the latest heart rate reading of a particular user


        GET http://localhost:4000/api/v1/users/heart/latest/:id
         
### Appointment Routes

> These routes should be used to do all appointment related stuff.

- This route will return all the appointments for a given user


        GET http://localhost:4000/api/v1/appointments/appointmentbyid/:id
        
- This route will update the status of the given appointment


        PATCH http://localhost:4000/api/v1/appointments/appointmentbyid/:id

### Report Routes

> These routes should be used to do all reports related stuff.

- This route will return all the reports for that specific user


        GET http://localhost:4000/api/v1/users/reports/getreportsbyuser/:id

- This route should be used to create a new report detail entry for a particular report. The body should be form-data. The field name for the file upload should be 'reportDetails'


        POST http://localhost:4000/api/v1/users/reports/reportdetails
                

### QR Code Routes

> This route shall be used to create/ retrive QR Code for a user.

- This route will create the qr code for the given user. It accepts user_id as an input in body.


        POST http://localhost:4000/api/v1/users/qrcode
        
- This route will return the qr code for a particular user.


        GET http://localhost:4000/api/v1/users/qrcode/:id