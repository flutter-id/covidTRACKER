<p align="center"><a href="https://flazhost.com" target="_blank"><img src="https://i.postimg.cc/yxCQHLcT/covid-TRACKER-svg.png" width="600"></a></p>

# covidTRACKER

covidTRACKER is a Mobile Application to help organization or governement to track user who has been sentenced as Negative or Positive pasient. This will help you to track acitivy after being sentenced. This Idea comes from assignment on Udacoding Academy [UdaCoding.Com](https://udacoding.com) Special thank to Uda Rizki who guided me to **coding hard**.

## Features:

- Status Record
- Story to Write Your Opinion
- Written on Laravel as Backend
- Written on Dart Flutter as Mobile Application

---

# Steps of Installation

### Create Database

`create database covid;`

### Change Database Configuration on .env

```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=covid
DB_USERNAME=root
DB_PASSWORD=admin
```

### Run Laravel

```
php artisan serve --host 192.168.1.7 --port 8000
```

### Install covidTRACKER by Access URL:

```
http://192.168.1.7:8000/install
```

<img src="https://i.postimg.cc/d3PmzDrk/installation.png" height="400" />

### Connect Mobile Application to Back End Server

<img src="https://i.postimg.cc/D0rdFFPC/connection.png" height="1000" />

### Login Using email and Passwod

```
Email    : admin@admin.com
Password : 12345678
```

# # Back End Features

#### User

1. Registration
2. Login
3. Logout

#### Story

1. Create Story
2. List Story

#### Status

1. Create Status
2. List Status

#### Indonesian Region

1. Province
2. Regency
3. District
4. Villlage

## Backend Technology

1. Laravel 8
2. Eloquent
3. Collection
4. Resource
5. Passport

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
