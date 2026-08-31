# Book Collection

Book Collection is a Ruby on Rails application for creating, viewing, editing,
and deleting books. It was created for the CSCE 431 Docker and Git/GitHub labs.

## Requirements

- Docker Desktop with the WSL 2 backend on Windows
- The course image: `paulinewade/csce431:sp26v1`

## Run the application

From the directory containing this project, start the course container and then
run the Rails server inside the container:

```bash
rails server --binding=0.0.0.0
```

Open <http://127.0.0.1:3000/books> to use the application.

## Test

```bash
rails test
```
