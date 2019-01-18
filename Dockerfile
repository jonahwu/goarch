FROM golang:latest AS build

ENV GOARCH_SRC=$GOPATH/src/github.com/goarch
#ENV CGO_ENABLED=1
#ENV GOOS=linux
#ENV NOMS_VERSION_NEXT=1
#ENV DOCKER=1

RUN mkdir -pv $GOARCH_SRC
COPY . ${GOARCH_SRC}
RUN go test github.com/goarch/...
RUN ls $GOPATH/src/github.com/goarch/cmd/goarch -alh
RUN cd $GOPATH/bin && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build github.com/goarch/cmd/goarch
#RUN go install -v 
RUN cp $GOPATH/bin/goarch /bin/goarch
RUN ls $GOPATH/bin/ -alh
RUN ls /bin/ -alh

FROM alpine:latest

COPY --from=build /bin/goarch /goarch
RUN ls / -alh
#VOLUME /data
EXPOSE 8000

ENV NOMS_VERSION_NEXT=1
RUN chmod +x ./goarch
ENTRYPOINT [ "./goarch" ]

#CMD ["serve", "/data"] ]
