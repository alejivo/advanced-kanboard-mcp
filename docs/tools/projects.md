---
title: Projects and tasks
parent: Tools
nav_order: 1
description: List and create projects, and create, update, move, or delete tasks.
---

# Projects and tasks

Eight tools cover projects and tasks.

| Tool | Description | Example |
| --- | --- | --- |
| `get_projects` | List the projects you can see | "Show me all my projects" |
| `create_project` | Create a project (app admin or app manager) | "Create a new project called Mobile App" |
| `get_tasks` | List tasks in a project | "List all tasks in the Marketing project" |
| `create_task` | Create a task | "Add a task to implement user authentication" |
| `update_task` | Change a task | "Update the login task description" |
| `delete_task` | Remove a task | "Delete the obsolete testing task" |
| `get_task_details` | Read one task in full | "Show me full details for task #123" |
| `move_task` | Move a task to another column | "Move the API task to the Done column" |

`get_projects`, `get_tasks`, and `get_task_details` are read tools. They return only boards the token user can see.

`create_project` adds the token user as the project owner and manager. A project manager who is not an app admin or app manager does not get this tool.

`create_task`, `update_task`, and `move_task` need project member, project manager, or a custom project role that Kanboard still allows to change tasks. App admins can use them on every active project.

`delete_task` is narrower. A project member can delete tasks they created. A project manager can delete any task in the project. A custom role follows the same task access as a member, minus that role's Kanboard restrictions.
