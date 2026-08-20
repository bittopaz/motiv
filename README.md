# Motiv

Motiv is a small motivation and goal-tracking web app built with **Ruby on Rails**.
Create goals, capture the "why" behind each one, and check them off as you make progress.

## Tech stack

- **Ruby** 4.0.6
- **Rails** 8.1.3.1
- **SQLite** for development, test, and production data
- **Hotwire** (Turbo + Stimulus) and **Propshaft** asset pipeline (Rails 8 defaults, no Node build step)

## Requirements

- Ruby 4.0.6 (see [`.ruby-version`](.ruby-version))
- Bundler
- SQLite 3

## Getting started

```bash
bundle install        # install gem dependencies
bin/rails db:prepare  # create and migrate the database
bin/rails server      # boot the app at http://localhost:3000
```

The root path (`/`) shows the Goals dashboard.

## Common commands

| Task | Command |
| --- | --- |
| Run the app | `bin/rails server` |
| Run the test suite | `bin/rails test` |
| Lint (RuboCop) | `bin/rubocop` |
| Security scan (Brakeman) | `bin/brakeman` |
| Rails console | `bin/rails console` |

## Project layout

- `app/models/goal.rb` — the `Goal` model (title, motivation, completed).
- `app/controllers/goals_controller.rb` — CRUD plus a `toggle` action to complete/reactivate a goal.
- `app/views/goals/` — the goals dashboard and forms.
- `test/` — model and controller tests.
