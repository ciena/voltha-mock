# VOLTHA Mock GRPC Server
This repository creates a Docker image that provides a *mock* GRPC VOLTHA
server that may be valuable for client testing.

## Usage
This mock server can support either VOLTHA v1 or v2 protocol buffers. To
select which protocol buffers to use either a `-1` or `-2` argument can
be used when starting the Docker container. The default is version `2`.

The mock server can be started using the following command:
```bash
docker docker run -tid --name voltha-mock --rm \
  -p 50051:50051 ciena/voltha-mock
```

## Mock Responses
The image is built with some based mock responses, nothing fancy and nothing much. These can be see in the `data.json` file in the [git
repository](http://github.com/ciena/voltha-mock).

To override the default mock responses mount the custom response file
as `/voltha/data.json` when the docker container is started, i.e.
`-v <path-to-responses>/<response-file.json>:/voltha/data.json`.

## Example
The following is an example session, installing and using [`voltctl`](https://github.com/ciena/voltctl) client against the mock
VOLTHA server:
### Setup
```bash
docker run -tid --name voltha-mock --rm -p 50051:50051 ciena/voltha-mock
mkdir ws
cd ws
export GOPATH=$(pwd)
go get github.com/ciena/voltctl/...
```
### Query Version
```bash
./bin/voltctl -a v2 -s localhost:50051 version
```
##### Query Version Response
```
Client Version: beta
Cluster Version: 0.0.1-mock
```
### List Adapters
```bash
./bin/voltctl -a v2 -s localhost:50051 adapter list
```
##### List Adapters Response
```
ID       VENDOR                   VERSION
acme     Acme Adapter Services    1.5.0
ollie    Ollie's OLTs & ONUs      1.0.3
```

### List Devices
```bash
./bin/voltctl -a v2 -s localhost:50051 device list
```
##### List Devices Response
```
ID                  TYPE        ROOT     PARENTID            SERIALNUMBER          VLAN    ADMINSTATE    OPERSTATUS    CONNECTSTATUS
00015bbbfdb3c068    acme_olt    true     0001aabbccddeeff    192.168.42.3:50060    0       ENABLED       ACTIVE        REACHABLE
0001552615104a2c    acme_onu    false    00015bbbfdb3c068    ACME012345678C        128     ENABLED       ACTIVE        REACHABLE
0001552615104a2d    acme_onu    false    00015bbbfdb3c068    ACME012345678D        129     ENABLED       ACTIVE        REACHABLE
0001552615104a2e    acme_onu    false    00015bbbfdb3c068    ACME012345678E        130     ENABLED       ACTIVE        REACHABLE
0001552615104a2f    acme_onu    false    00015bbbfdb3c068    ACME012345678F        131     DISABLED      FAILED        UNREACHABLE
```
### Tear down
```bash
docker rm -f voltha-mock
```
