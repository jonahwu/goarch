package main

import (
	"flag"
	"fmt"
	"github.com/goarch/go/jutils"
	"github.com/golang/glog"
)

func main() {
	flag.Parse()
	// here we setup the default stdout for glog
	flag.Lookup("logtostderr").Value.Set("true")
	data := jutils.GetHello()
	fmt.Println(data)
	glog.Info("now into data")
	//glog.Error("glog in errorla")
	glog.Flush()
	select {}
}
