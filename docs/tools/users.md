---
title: Users and assignment
parent: Tools
nav_order: 5
description: List users, assign tasks, set due dates, and read or add comments.
---

# Users and assignment

Five tools cover people, dates, and comments.

| Tool | Description | Example |
| --- | --- | --- |
| `get_users` | List users you can interact with | "Show me the team members" |
| `assign_task` | Assign a task to a project member | "Assign the API task to John" |
| `set_task_due_date` | Set a deadline | "Set the due date for the login task to next Friday" |
| `add_task_comment` | Add a comment | "Add a comment about testing requirements" |
| `get_task_comments` | Read comments on a task | "Show all comments on this task" |

`get_users` and `kanboard://users` return only `id`, `username`, and `name`. They do not return password hashes, API tokens, or two-factor secrets. An app admin can list users across the instance. Other roles see the users they are allowed to interact with.

`assign_task`, `set_task_due_date`, and `add_task_comment` follow the same task-write rules as creating or updating a task.

`get_task_comments` is a read tool. It follows Kanboard's application-role visibility rules for the token user. Each comment includes its id, task id, user id, username, name, body, dates, and visibility. It does not include email, avatar path, or other profile details.
