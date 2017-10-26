# Docker Image Templating System

A tiny framework for developing Docker images.

## Features

- [Mustache templating system](https://mustache.github.io)
	 - Variables
	 - Sections
	 - Partials
- Includes

## Why Would I Use This

Developing Dockerfiles can be rigid. A lack of features such as variable
substitution and partials can lead to duplicated effort. DITS provides a simple
reusable framework for easing the Dockerfile development process.

## Structure

* `bin` - Framework binaries for automated tasks, such as generation
* `dist` - Generated artifacts used to build Docker images
* `etc` - Framework configuration
* `includes` - Included resources for generated artifacts
* `templates` - Scriptable templates that generate Dockerfiles


## Usage

### Artifacts

Generator will compile each `*.dockerfile.mustache` template in the `templates`
directory.

``` bash
# templates/example.dockerfile.mustache
FROM debian:stable
```

Run `make generate` from project root.

``` bash
# dist/example/Dockerfile
FROM debian:stable
```

### Variables

Variables are defined in `etc/config.yml` and can only be substituted in
`*.mustache` templates.

``` mustache
<!-- templates/example.dockerfile.mustache -->
FROM debian:stable
RUN echo {{ message }}
```

``` yml
# etc/config.yml
message: "Hello, world!"
```

Run `make generate` from project root.

``` bash
# dist/example/Dockerfile
FROM debian:stable
RUN echo Hello, world!
```

See [mustache manual](https://mustache.github.io/mustache.5.html) for detailed
documentation.

### Partials

Partials are included relative to the `templates` directory.

``` mustache
<!-- templates/example.dockerfile.mustache -->
FROM debian:stable
{{> partials/example}}
```

``` mustache
<!-- templates/partials/example.mustache -->
RUN echo "I'm a partial!"
```

Run `make generate` from project root.

``` bash
# dist/example/Dockerfile
FROM debian:stable
RUN echo "I'm a partial!"
```

See [mustache manual](https://mustache.github.io/mustache.5.html) for detailed
documentation.

### Includes

Resources can be included to each artifact directory with `INCLUDE` declaration
in `*.mustache` templates. They are copied relative to the `includes` directory.

``` mustache
<!-- templates/example.dockerfile.mustache -->
FROM debian:stable
INCLUDE example.txt
```

``` sh
# includes/example.sh
echo "I'm an example include"
```

Run `make generate` from project root.

``` bash
# dist/example/Dockerfile
FROM debian:stable
```

``` bash
# dist/example/example.sh
echo "I'm an example include"
```

## Further Reading

- [Mustache Manual](https://mustache.github.io/mustache.5.html)
