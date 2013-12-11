# Moody

Simple, email-driven mood tracker designed for Heroku.

## What does it do?

Once you set up the app (instructions below), you'll get an email periodically that asks how you're feeling. Reply to it with something like this:

    Happy

    Just finished a long run, woot!

And the app will record the emotion and your notes for later review.

The app is set up with a 25% chance of sending the email at each interval (which you set up in the Scheduler add-on) -- but if you haven't replied to the last email yet, it will hold off until you do (so they don't pile up while you're sleeping).

## Instructions

Check it out locally, then:

    $ heroku create
    $ heroku config:set RECIPIENT=[your email]
    $ heroku run rake db:migrate
    $ heroku addons:add mailgun
    $ heroku addons:add scheduler
    $ heroku addons:open scheduler

Set up a scheduler task to run `rake prompt` at regular intervals.

## To-do

* Visualization
