Spring 2022
=
67-272 miniPATS  v1
=
This is a basic Rails app that was built as a class demonstration in the spring of 2022.  This first version of the project is designed help students become more familiar with the basics of the Rails 5.2 framework; future versions will add the rest of the application components.

The class is Application Design & Development (67-272) and is for students in Information Systems at Carnegie Mellon University in Qatar. We have posted this code on [github.com](https://github.com/S22-67-272Q/miniPATS) in a public directory so that (a) it is readily accessible to students and (b) that students will get a little familiarity with github.com.

Setup
--
This version of the project requires only a sqlite3 database.  After cloning this repo, install all gems with the `bundle install` on the command line.  

To set up the database and populate it with realistic sample records, run on the command line `rails db:populate`.   The populate script will remove any old databases, create new development and test databases, run all the migrations to set up the structure and add in the triggers, and then create 240 owners with over 450 pets and several thousand visits. (Every run will generate a different set of data).

This version of miniPATS is not complete yet, we will work on completing it throughout this semester.
