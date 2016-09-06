load test_helper

@test "zookeeper client is connected successfully with welcome message" {
  run docker run --rm  --network vnettest  -e ZOO_LOG4J_PROP=ERROR smizy/zookeeper zkCli.sh -server zookeeper-1.vnettest
  [ $status -eq 0 ]
  [ "${lines[0]}" = "Connecting to zookeeper-1.vnettest" ]
  [ "${lines[1]}" = "Welcome to ZooKeeper!" ]
}

@test "zookeeper output [zookeeper] with ls /" {
  run docker run  --rm  --network vnettest -e ZOO_LOG4J_PROP=ERROR smizy/zookeeper zkCli.sh -server zookeeper-1.vnettest ls / 
  [ $status -eq 0 ]

  n=$(( ${#lines[*]} -1 ))
  [ "${lines[$n]}" = "[zookeeper]" ]
}