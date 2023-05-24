# README

Full Stack Challenge - https://gist.github.com/thiagosil/ee725fa09c796a1b5727afaac07c6bc7

Details for setup are as follows:

* Ruby version -
1. Ruby - 3.1.2
2. Rails - 7.0.4.3
3. rbenv - 1.2.0

* System dependencies -
1. node - 16.20.0
2. npm - 8.19.4
3. PostgresSQL - 14.8
4. yarn - 1.22.19

* Configuration -
Perform a git pull from the repository and ensure all commits are in the project.

run ```bundle install --gemfile``` to install all the gems in the Gemfile.
run ```rails javascript:install:esbuild``` to install esbuild.
run ```rails turbo:install stimulus:install``` to install Turbo and Stimulus.
run ```rails css:install:bootstrap``` to install Bootstrap.

* Database creation -

run ```rails db:migrate``` to create the tables.

* Database initialization -

There is no requirement of seed data, you can create Borrowers and Invoices from the UI.

* How to use the UI -

To begin using the UI, run ```bin/dev``` and open a web browser to ```http://localhost:3000/```.

* How to run the test suite -

1. Unit tests:
run ```rspec``` to run the unit tests.

2. Integration tests:
run ```yarn add react-scripts``` one time to set up the react integration testing related files.
run ```bin/dev``` to start the server.
In another tab, run ```TEST=integration rspec``` to run the integration tests.

* Improvements that can be added in the future -

1. Add pagination to the respective Borrowers and Invoices view pages.
2. Add an index to the Invoice status to allow searching and sorting based on the status.
3. Integration testing has only been added for the Acceptance Criteria (change of states of Invoice). Integration testing ought to be added for other workflows (e.g. clicking of back buttons).
4. Scan uploading has only had the base aspects complete (like incorporating ActiveStorage, Model and Controller changes). The actual uploading of scans was running into issues with the "active_model_serializer" gem not serializing the scan as expected. As this was not part of the Acceptance Criteria, the finalization of this was skipped but can be incorporated easily after debugging the serialization issues.