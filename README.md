## Project Description

Task Manager API is a simple application written in Symfony 6.3, used for managing tasks (todo list) via REST API. The application includes the following functionalities:

- Displaying a list of tasks
- Adding new tasks
- Editing existing tasks
- Deleting tasks
- Marking tasks as completed
- Task prioritization

The application uses PostgreSQL database for storing tasks and Redis for caching query results.

## Tests and code quality

The project includes:

1. Unit and functional tests using PHPUnit
```bash
composer test
```
2. Static code analysis using PHPStan (level 5)
```bash
composer stan
```
3. Code formatting using Symplify/Easy-Coding-Standard
```bash
# To check
composer cs

# To fix
composer cs-fix
```

## Technical Requirements

- PHP 8.1 or higher
- Composer
- PostgreSQL 15
- Redis 6.0
- Symfony CLI (optional)

**CI/CD Configuration**

After every commit or pull request on main branch the pipeline is triggered:
The pipeline is:
- Running static code analysis:
  - composer test
  - composer stan
  - composer cs
- Building and tagging Docker images
- Pushing Docker images to DockerHub

### Building and running your application

When you're ready, start your application by running:
`docker compose up --build`.

Your application will be available at http://localhost:9000.

### Running the application and doing manual code analysis

1. Make your own version of the .env.dev and fill in the variables


2. Run the environment in detached mode

```
docker compose up -d
```

or if it dosen't work for you use

```
docker-compose up -d
```

3. Get the development container ID

```
docker ps
```

4. Connect to the container

```
docker exec -it <container_id> /bin/bash
```

5. Perform code analysis using commands:

Unit and functional tests using PHPUnit
```bash
composer test
```

Static code analysis using PHPStan (level 5)
```bash
composer stan
```

Code formatting using Symplify/Easy-Coding-Standard
```bash
# To check
composer cs

# To fix
composer cs-fix
```
