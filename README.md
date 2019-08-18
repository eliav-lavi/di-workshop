# Dependency Injection Workshop
This workshop is intended to serve as a laboratory for experimenting with dependency injection techniques. The goal is to implement two routes in a parking lot management app named `Parka`: `check_in` and `check_out`. There are templates for relevant service objects that your goal is to implement.

The application is built as a Roda app that you can run & serve locally. Read more about Roda [here](http://roda.jeremyevans.net/).

## Getting Started

1. Clone this repository onto your local machine.
2. Run `bundle install`.
3. Run the server using `rerun rackup`. Rerun will restart and reload the server once you edit the code. You should now have a running server at `localhost:9292`.

## Goals & Challenges
There are two routes to implement: `/check_in` and `/check_out`.

### /check_in
Start with implementing `/check_in` in a naïve manner. You should implement `Parka::CheckIn::Service`:
* propose a `.build` method that creates an instance (the route will call this class method in order to get a working instance).
* implement the `#call` method which expects a `Parka::CheckIn::Request`. The route will parse the incoming JSON body into this `Dry::Struct` - have a look at it to understand what does the route's API look like!
* Your `#call` method should create a new `Parka::CheckIn::Model`, representing the check in record to be persisted in the database. You may use std-lib's `SecureRandom` in order to generate a random id for the check in. Persist this model into the database using the repository, `CheckIn::Repo`.
* Your `#call` method should return the newly created & persisted model.

#### Points To Consider

* How do you handle a request with a `vehicle_type` which is not supported?
* Perhaps your application be more realistic by rejecting check_in requests in case the parking lot is full. How could this be modeled?

### /check_out
After having completed & testing the `/check_in` route, continue to implementing `Parka::CheckOut::Service`.
As the former, this service should also respond to `.build` and `#call`. The `#call` method expects a `Parka::CheckOut::Request` which the route will parse for you. 

Your `#call` method should:
* Find the matching check_in in the `CheckIn::Repo`.
* Calculate the charge for the stay using some other service object (perhaps `Parka::Charge::Services::Calculator`?). Feel free to propose your own charging logic, but please take into account the length of the stay and the type of the vehicle as factor.
* Persist a `Parka::Charge::Model` into the database using a `Parka::Charge::Repo` instance.
* Delete the check_in from the database
* Send a summary email including some info: the id of the check_in, the length of the stay and the amount that was charged. Your email client may simply print the email onto into `$stdout`, do not worry about actually sending emails.

#### Points To Consider

* How do you handle the case when the passed `check_in_id` does not exist in the database?
* How do you handle the case when the charge service is down or returns an unsucessful response?
* Perhaps a more realistic modelling would ask for a payment method upon `/check_in`. Consider adding it to the check in process and using this data in the charging process.
* What is the return value of this service & route?

Good luck & happy learning!
