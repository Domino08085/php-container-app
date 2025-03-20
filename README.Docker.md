### Building and running your application

When you're ready, start your application by running:
`docker compose up --build`.

Your application will be available at http://localhost:9000.

### PHP extensions
If your application requires specific PHP extensions to run, they will need to be added to the Dockerfile. Follow the instructions and example in the Dockerfile to add them.

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