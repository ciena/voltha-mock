# VOLTHA Mock GRPC Server
This repository creates a Docker image that provides a *mock* GRPC VOLTHA
server that may be valuable for client testing.

# Usage
This mock server can support either VOLTHA v1 or v2 protocol buffers. To
select which protocol buffers to use either a `-1` or `-2` argument can
be used when starting the Docker container. The default is version `2`.

The mock server can be started using the following command:
```
docker docker run -tid --name voltha-mock --rm \
  -p 50051:50051 ciena/voltha-mock
```

# Mock Responses
The image is built with some based mock responses, nothing fancy and nothing much. These can be see in the `data.json` file in the [git
repository](http://github.com/ciena/voltha-mock).

To override the default mock responses mount the custom response file
as `/voltha/data.json` when the docker container is started, i.e.
`-v <path-to-responses>/<response-file.json>:/voltha/data.json`.
