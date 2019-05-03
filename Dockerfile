# Copyright 2019 Ciena Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
FROM ciena/grpc-mock as build
MAINTAINER Ciena Corporation

RUN apk add --update git

WORKDIR /voltha
RUN mkdir /voltha/protos
RUN git clone https://github.com/opencord/voltha /tmp/v1
RUN cp -r /tmp/v1/voltha/protos/ v1/
RUN git clone https://github.com/opencord/voltha-protos /tmp/v2
RUN cp -r /tmp/v2/protos/ v2/
RUN git clone https://github.com/protocolbuffers/protobuf /tmp/pb
RUN cp -r /tmp/pb/src/google /voltha/protos
COPY clean.sh /voltha/clean.sh
RUN /voltha/clean.sh

FROM ciena/grpc-mock
ENV GRPC_MOCK_COMPARE=sparse
WORKDIR /voltha
COPY --from=build /voltha /voltha
COPY mock.sh clean.sh mock-v1.js mock-v2.js data.json /voltha/
RUN chmod 755 /voltha/mock.sh /voltha/clean.sh

ENTRYPOINT ["/voltha/mock.sh"]
