Baker's Oven
============

An easy way to create valid hpubs for the Baker Framework.

About Baker
-----------

Baker Framework allows simple creation of HTML5-based eBooks. There is
a simple specification for html-based books that has been developed for
Baker - hpub.

Installing Baker's Oven
--------------------

Baker's Oven is a padrino-based application (running on Ruby). To
install:

1. Download Baker's Oven
2. `$ bundle install`
3. `$ padrino rake dm:auto:migrate`
4. `$ padrino rake seed`

By default, the database for Baker's oven will be SQLite3. The seed step
allows you to set an administrator username/password.


Running Baker's Oven
--------------------

1. `$ rackup`
2. Go to the admin panel in your browser: http://localhost:9292/admin
3. Follow directions to create book
4. Preview at http://localhost:9292/

Running on a Remote Server
--------------------------

Currently not supported - need to figure out the most efficient way to
allow multiple books to be built (currently all built in a single tmp/book dir
in the filesystem).
